function M_hat = sdp_optim(M, rho, d)
    yalmip('clear')
    M_hat = sdpvar(d,d);
    Constraints = [M_hat >= 0, trace(M_hat) <= 1];
    Objective = trace(M*M_hat) - rho*norm(M_hat(:), 1);
    sol = optimize(Constraints, -Objective, sdpsettings('verbose', 0));
    M_hat = value(M_hat);
end
