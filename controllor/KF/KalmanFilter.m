function [x_est, P] = KalmanFilter(u, y, A, B, C, Q, R)
% 离散卡尔曼滤波器 
% 输入:
%   y : 当前时刻观测值 (m x 1)
%   u : 当前时刻控制输入 (p x 1)，若无控制输入可设为 []
% 输出:
%   x_est : 当前时刻状态估计 (n x 1)

    n = length(A(:,1));
    % 初始状态（仅在第一次调用时使用）
    x0 = zeros(n, 1);             % 初始状态估计 (n x 1)
    P0 = eye(n);             % 初始误差协方差 (n x n)
    % ===================================================

    % 声明 persistent 变量（在仿真中保持状态）
    persistent x_post P_post first_time
    
    % 初始化（仅在第一次调用时执行）
    if isempty(first_time)
        x_post = x0;
        P_post = P0;
        first_time = false;
    end

    % ---------- 预测步骤 ----------
    if nargin > 1 && ~isempty(B) && ~isempty(u)
        % 有控制输入
        x_prior = A * x_post + B * u;
    else
        % 无控制输入
        x_prior = A * x_post;
    end
    P_prior = A * P_post * A' + Q;

    % ---------- 更新步骤 ----------
    S = C * P_prior * C' + R;        
    K = P_prior * C' / S;            

    y_residual = y - C * x_prior;    
    
    x_post = x_prior + K * y_residual;       
    P_post = (eye(size(A)) - K * C) * P_prior; 

    % 输出当前状态估计
    x_est = x_post;
    P = P_post;
end