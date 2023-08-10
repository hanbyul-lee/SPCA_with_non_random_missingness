function [u, v] = TSPCA(M, d, alpha, gamma)
    %% Diagonal thresholding SPCA
    med_diag = median(diag(M));
    J = (diag(M) >= med_diag*(1+alpha));

    M_reduced = M;
    M_reduced(:,~J) = 0; M_reduced(~J,:) = 0;
    [u,d1] = svds(M_reduced, 1);
    if d1 == 0 % when M_reduced == 0
        u = zeros(d,1);
        v0 = randn(d,1);
        v0 = v0/norm(v0);
    else
        v0 = u;
    end
    
    %% Iterative thresholding SPCA
    diff = 1;
    max_iter = 5000;
    iter = 1;
    while diff > 1e-7
        v = M*v0;
        v(abs(v)<gamma) = 0;
        if norm(v) ~= 0
            v = v/norm(v);
        end
        diff = norm(v-v0);
        v0 = v;
        if iter>max_iter
            break
        end
        iter = iter+1;
    end
end

