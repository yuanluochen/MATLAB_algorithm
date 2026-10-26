% LESO 参数计算
% A_e_temp = [A_LQR; zeros(1, 4)];
% A_e = [A_e_temp, zeros(5, 1)];
% A_e(3, 5) = 1;
B_d = [zeros(2, 2); eye(2)];
A_e = [A_LQR, B_d;           % 第5列等于B_LQR
       zeros(2, 4), zeros(2, 2)]; 

% disp(A_e);
B_e = [B_LQR; zeros(2,2)];
C_e = [C_LQR, zeros(3,2)];
OBSER = obsv(A_e, C_e);
% 判断能观性
if rank(OBSER) == size(A_e,1)
    disp('系统是可观测的');
else
    disp('系统不可观测');
end
[~, lambda_LESO] = eig(OBSER' * OBSER);
disp(lambda_LESO);

sys_leso = ss(A_e, B_e, C_e, 0);
sys_leso_d = c2d(sys_leso, T_s, 'zoh');   % 零阶保持
Ad = sys_leso_d.A;
Bd = sys_leso_d.B;
Cd = sys_leso_d.C;

% pole_disc = [0.98, 0.97, 0.96, 0.95, 0.93, 0.91];
pole_disc = [0.7, 0.75, 0.8, 0.85, 0.88, 0.9];



L = place(Ad', Cd', pole_disc)';

disp(norm(L));
% save parameter
LESO_parameter_D.A = Ad;
LESO_parameter_D.B = Bd;
LESO_parameter_D.C = Cd;
LESO_parameter_D.L = L;
alpha = [0.8,0.8,0.8];   % 三个输出通道的非线性指数 (0<alpha<1)
delta = [0.05,0.05,0.05]; % 线性区间宽度
LESO_parameter_D.alpha = alpha;
LESO_parameter_D.delta = delta;

A_obs = Ad - L * Cd;
eig_obs = eig(A_obs);
mod_eig = abs(eig_obs);
disp(eig_obs);
if all(mod_eig < 1)
    disp('所有观测器极点均在单位圆内，系统稳定。');
else
    disp('存在极点模 >= 1，观测器不稳定！');
end
% 绘制极点分布
figure;
zplane(eig_obs, 1);
title('离散观测器极点分布');

