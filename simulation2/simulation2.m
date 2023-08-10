function simulation2(spec_gap, sd, num_iter)
    d = 50; s = 10;
    rng('shuffle')
    
    rho_list = 0.025:0.025:1;
    
    threshold = 1e-4;
    
    num_edges = 1250;
    gp_list = 0:2:14;
    for gp = gp_list
        iter = 0;
        while iter < num_iter
            %% Create Adjacency Matrix
            p = num_edges/(d^2);
            while 1
                A = triu(rand(d,d)<=p);
                A = triu(A,1) + A';
                if (sum(sum(A)) ~= num_edges)
                    continue
                end
                A1 = A(1:s,1:s);
                L = diag(sum(A1))-A1;
                eL = eig(L);
                L_eig_2 = eL(2);
                if L_eig_2 < 0 
                    L_eig_2 = 0;
                end
                A1_tilde = ones(s) - eye(s) - A1;
                L_tilde = diag(sum(A1_tilde)) - A1_tilde;
                eL_tilde = eig(L_tilde);
                L_eig_2_tilde = eL_tilde(2);
                if L_eig_2_tilde < 0 
                    L_eig_2_tilde = 0;
                end
                delta_min = min(sum(A1));
                delta_max = max(sum(A1));
                temp_gp = max([delta_max-L_eig_2, s-delta_min-L_eig_2_tilde])/L_eig_2;
                if (temp_gp > gp) && (temp_gp <= gp+2)
                    break
                end
            end
            
            A_tilde = max([max(sum(A((s+1):d,1:s)')), max(sum(A((s+1):d,1:s))), max(sum(A((s+1):d,(s+1):d)))]);
            
            graph_properties = [gp, temp_gp, delta_min, delta_max, L_eig_2, L_eig_2_tilde, A_tilde];
              
            %% Generate Data
            u1 = [ones(s,1); zeros(d-s,1)]/sqrt(s);
            U = [u1, null(u1')*orth(randn(d-1, d-1))];
            D = sort(randn(d,1), 'desc');
            D(1) = D(2) + spec_gap;
            true_M = U*diag(D)*U';
            
            %% Add Noise
            N = sd*triu(randn(d));
            N = triu(N,1) + N';

            M = (true_M + N).*A;
            
            M1 = norm(true_M(1:s,1:s));
            M2 = norm(true_M(1:s,(s+1):d));
            M3 = norm(true_M((s+1):d,(s+1):d));
        
            %% SDP
            M_hat = sdp_optim(M, 0, d);
            var0 = trace(M*M_hat);

            res = []; sdp_res = [];
            for rho = rho_list
                M_hat = sdp_optim(M, rho, d);
                if abs(sum(diag(M_hat))-1) > 1e-7
                    break
                end
                var1 = trace(M*M_hat);
                num_select = sum((diag(M_hat) > threshold));
                cp = var1/var0 + (d-num_select)/d;
                exact_recovery = double(sum((diag(M_hat)>threshold)==[ones(s,1); zeros((d-s),1)])==d);
                res = [res; [cp, exact_recovery]];
                sdp_res = [sdp_res, exact_recovery];
            end
            [~,max_idx] = max(res(:,1));
            selected_sdp_res = res(max_idx,2);
                        
            results = [graph_properties M1 M2 M3 selected_sdp_res sdp_res];
            formatSpec = '%d, %.4f, %d, %d, %.4f, %.4f, %d, %.4f, %.4f, %.4f, '+join(repelem("%d,",length(results)-11))+' %d\n';

            fileID = fopen(strcat(['results/s', int2str(s), '_spec_gap', int2str(spec_gap), '_sd', num2str(sd,'%.0e'), '.csv']), 'a+'); 
            fprintf(fileID, formatSpec, results);
            fclose(fileID);
            
            iter = iter+1;
        end
        fprintf('.')        
    end
end