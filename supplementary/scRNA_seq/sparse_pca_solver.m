function [Y obj] = sparse_pca_solver(B,rho,iters,eta);

fprintf('Running ');
B = (B+B.')/2;
n = size(B,1);
Y = zeros(n);
obj = zeros(1,iters);
for t = 1:iters
    if mod(t,10) == 1
        fprintf('.');
    end
	Y = Y + eta/sqrt(t) * B;
	Y = sign(Y).*max(0,abs(Y) - rho*eta/sqrt(t+1));
    [U D] = eig(Y);
    d = diag(D).';
	[u idx] = sort(d,'descend');
	tmp = (cumsum(u,2)-1)./(1:n);
	phi = sum(u>tmp);
	lam = 1/phi*(1-sum(u(1:phi)));
	x = max(u + lam,0);
	x_unsorted = zeros(1,n);
	x_unsorted(idx) = x;
	Y = U*diag(x_unsorted)*U.';
	obj(t) = sum(sum(B.*Y)) - rho * sum(sum(abs(Y)));
end
fprintf('\n');
