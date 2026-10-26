function [u_k, initval] = Prediction(x_k, MPC_parameter)
    U_k = zeros(MPC_parameter.N * MPC_parameter.p,1); % NP x 1
    options = optimoptions('quadprog', 'Display', 'off'); 
    H = (MPC_parameter.H + MPC_parameter.H')/2;
    f = MPC_parameter.E * x_k;
    U_k = quadprog(H, f, [], [], [], [], MPC_parameter.lb, MPC_parameter.ub, MPC_parameter.initval, options);
    u_k = U_k(1 : MPC_parameter.p,1); % 取第一个结果
    initval = [U_k(MPC_parameter.p + 1 : end, 1); zeros(MPC_parameter.p, 1)];
end 

