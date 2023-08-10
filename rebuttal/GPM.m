function [supp_est1, supp_est2] = GPM(M, delta)
   
    [a, b] = max(sqrt(sum(M.^2)));
    
    %% Algorithm 2 in Journee et al. (2010)
    x0 = M(:,b)/a;
    
    diff = 1;
    max_iter = 5000;
    iter = 1;
    while diff > 1e-7
        x1 = M*x0 - delta;
        x1(x1 < 0) = 0;
        x2 = sign(M*x0);
        x = sum(x1.*x2.*M);
        x = x'/norm(x);
        diff = norm(x-x0);
        x0 = x;
        if iter>max_iter
            break
        end
        iter = iter+1;
    end
    
    supp_est1 = abs(M*x) > delta;
    
    %% Algorithm 3 in Journee et al. (2010)    
    x0 = M(:,b)/a;
    delta = delta^2;
    
    diff = 1;
    max_iter = 5000;
    iter = 1;
    while diff > 1e-7
        x = sum((sign((M*x0).^2-delta).*(M*x0)).*M);
        x = x'/norm(x);
        diff = norm(x-x0);
        x0 = x;
        if iter>max_iter
            break
        end
        iter = iter+1;
    end
    
    supp_est2 = (M*x).^2 > delta;    
end