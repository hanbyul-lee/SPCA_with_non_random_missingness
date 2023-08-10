function main(num_edges, sd, num_iter)
    rng("shuffle")
    pitprops = readtable("pitprops.csv");
    true_M = table2array(pitprops(:,2:end));
    d = length(true_M);

    true_support = [1,2,7,8,9,10];
    true_idx = zeros(d,1);
    true_idx(true_support) = 1;
    s = length(true_support);

    rho_list = 0.025:0.025:1;
    alpha_list = 0:0.5:7;
    gamma_list = 0:0.5:7;

    threshold = 1e-4;

    gp_list = 0:0.2:2;
    for gp = gp_list
        iter = 0;
        while iter < num_iter
            sdp_res = [];
            sdp_complete_res = [];
            dt_res = [];
            it_res = [];
            dt_complete_res = [];
            it_complete_res = [];

            %% Create Adjacency Matrix
            p = num_edges/(d^2);
            while 1
                A = triu(rand(d,d)<=p);
                A = triu(A,1) + A';
                if (sum(sum(A)) ~= num_edges)
                    continue
                end
                A1 = A(true_support,true_support);
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
                if (temp_gp > gp) && (temp_gp <= gp+0.2)
                    break
                end
            end

            graph_properties = [temp_gp, delta_min, delta_max, gp, L_eig_2, L_eig_2_tilde];

            %% Add Noise
            N = sd*triu(randn(d));
            N = triu(N,1) + N';

            M = (true_M + N).*A;

            %% SDP
            M_hat = sdp_optim(M, 0, d);
            var0 = trace(M*M_hat);

            res = [];
            for rho = rho_list
                M_hat = sdp_optim(M, rho, d);
                if abs(sum(diag(M_hat))-1) > 1e-7
                    break
                end
                var1 = trace(M*M_hat);
                num_select = sum((diag(M_hat) > threshold));
                cp = 0.6*var1/var0 + 0.4*(d-num_select)/d;
                exact_recovery = double(sum((diag(M_hat)>threshold)==true_idx)==d);
                res = [res; [cp, exact_recovery]];
                sdp_res = [sdp_res, exact_recovery];
            end
            [~,max_idx] = max(res(:,1));
            selected_sdp_res = res(max_idx,2);


            %% SDP with Completion
            M_complete = matrix_completion(M, A, d);
            M_hat = sdp_optim(M_complete, 0, d);
            var0 = trace(M_complete*M_hat);

            res = [];
            for rho = rho_list
                M_hat = sdp_optim(M_complete, rho, d);
                if abs(sum(diag(M_hat))-1) > 1e-7
                    break
                end
                var1 = trace(M_complete*M_hat);
                num_select = sum((diag(M_hat) > threshold));
                cp = 0.6*var1/var0 + 0.4*(d-num_select)/d;
                exact_recovery = double(sum((diag(M_hat)>threshold)==true_idx)==d);
                res = [res; [cp, exact_recovery]];
                sdp_complete_res = [sdp_complete_res, exact_recovery];
            end
            [~,max_idx] = max(res(:,1));
            selected_sdp_complete_res = res(max_idx,2);

            %% Thresholding
            for alpha = alpha_list
                for gamma = gamma_list
                    [u, v] = TSPCA(M, d, alpha, gamma);
                    exact_recovery = double(sum((v>sqrt(threshold))==true_idx)==d);
                    it_res = [it_res, exact_recovery];
                end
                exact_recovery = double(sum((u>sqrt(threshold))==true_idx)==d);
                dt_res = [dt_res, exact_recovery];
            end
            
            %% Thresholding with Completion
            for alpha = alpha_list
                for gamma = gamma_list
                    [u, v] = TSPCA(M_complete, d, alpha, gamma);
                    exact_recovery = double(sum((v>sqrt(threshold))==true_idx)==d);
                    it_complete_res = [it_complete_res, exact_recovery];
                end
                exact_recovery = double(sum((u>sqrt(threshold))==true_idx)==d);
                dt_complete_res = [dt_complete_res, exact_recovery];
            end

            results = [graph_properties, selected_sdp_res, selected_sdp_complete_res, sdp_res, ...
                sdp_complete_res, dt_res, it_res, dt_complete_res, it_complete_res];
            formatSpec = '%.4f, %d, %.4f, %.4f, %.4f, %.4f, '+join(repelem("%d,",length(results)-7))+' %d\n';

            fileID = fopen(strcat(['result_num_edges', int2str(num_edges), '_sd', num2str(sd,'%.0e'), '.csv']), 'a+'); 
            fprintf(fileID, formatSpec, results);
            fclose(fileID);

            iter = iter + 1;
            fprintf('.')
        end
    end
end