load("deng_5000.mat")
M = M-diag(diag(M));
d = length(M);
threshold = 1e-14;

[U, ~] = eig(M);
pca_explained_var = U(:,end)'*M*U(:,end); % same as largest among diag(D).
disp(pca_explained_var)
disp(sum(abs(U(:,end)) > sqrt(threshold)))

rho_list = [0.001, 0.005, 0.01, 0.05, 0.1, 0.5, 1];

%% SDP
var0 = pca_explained_var;

for rho = rho_list
    [M_hat, ~] = sparse_pca_solver(M, rho, 100, 2.0);
    if abs(sum(diag(M_hat))-1) > 1e-8
        break
    end
    var1 = trace(M*M_hat);
    num_select = sum((diag(M_hat) > threshold));
    cp = 0.4*var1/var0 + 0.6*(d-num_select)/d;
    fileID = fopen('sdp_res5000.csv', 'a+'); 
    fprintf(fileID, '%.4f, %.4f, %.4f, %d\n', [rho, cp, var1, num_select]);
    fclose(fileID);
end