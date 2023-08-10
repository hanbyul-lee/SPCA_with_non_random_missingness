function M_complete = matrix_completion(M, A, d)
    yalmip('clear')
    M_complete = sdpvar(d,d); 
    Constraints = [M_complete.*A == M];
    Objective = norm(M_complete, 'nuclear');
    sol = optimize(Constraints, Objective, sdpsettings('verbose', 0));
    M_complete = value(M_complete);
end