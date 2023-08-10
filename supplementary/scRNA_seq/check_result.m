res = readmatrix("sdp_res5000.csv");

[rho, sort_idx] = sort(res(:,1));
res(sort_idx,:)
[max_cp, max_idx] = max(res(:,2));
res(max_idx,:)