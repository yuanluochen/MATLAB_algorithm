clc;
clear;
data = readtable("19.2hz.csv");

%% 1. 输入信号
Fs = 1000;              % 采样频率 Hz
T = 1/Fs;               % 采样周期
t = table2array(data(:, 1));    % 时间序列
x_full = table2array(data(:, 3)); % 实际数据
x_full = x_full - mean(x_full);

N_total = length(x_full);

%% 只取后一半数据
start_idx = floor(N_total/2) + 1;   % 后一半的起点
x = x_full(start_idx:end);          % 后一半信号
t = t(start_idx:end);               % 对应时间（如需）
L = length(x);                      % 实际参与 FFT 的样本数

disp(max(x));

%% 2. FFT
Y = fft(x);

%% 3. 双边频谱
P2 = abs(Y/L);

%% 4. 单边频谱
P1 = P2(1:floor(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:floor(L/2))/L;    % 频率坐标
[~, idx] = min(abs(f - 50));

[sorted_P1, index] = sort(P1, 'descend');

figure(1)
plot(f(1:idx), P1(1:idx), '-', 'Color', [0, 0.4470, 0.7410], 'LineWidth', 1.5)
hold on;