# 个人常用 MATLAB 算法

整理自己科研/工程中常用的 MATLAB 算法脚本，涵盖控制器与信号分析工具。

## 目录

- [目录结构](#目录结构)
- **controllor/** — 控制器算法
  - [扩张状态观测器 (ESO)](controllor/ESO)
  - [卡尔曼滤波 (KF)](controllor/KF)
  - [模型预测控制 (MPC)](controllor/MPC)
- **tool/** — 分析工具
  - [FFT 频谱分析](tool/FFT_analy.m)
  - [Simulink 扫频模型](tool/sweep_freq.slx)


## 目录结构

```
MATLAB_algorithm/
├── controllor/
│   ├── ESO/            % 扩张状态观测器（含参数设计）
│   ├── KF/             % 离散卡尔曼滤波
│   └── MPC/            % 模型预测控制（矩阵构造 + 在线求解）
├── tool/
│   ├── FFT_analy.m     % FFT 频谱分析
│   └── sweep_freq.slx  % 扫频仿真模型
└── readme.md
```