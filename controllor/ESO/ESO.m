function hat_x = ESO(params, y, u)
    % 非线性扩张状态观测器 (NLESO)
    % 输入:
    %   params - 结构体，包含字段:
    %       A, B, C  - 离散状态空间矩阵
    %       L        - 观测器增益矩阵
    %       alpha    - 非线性函数 fal 的指数 (向量，长度=输出维数)
    %       delta    - 线性区间宽度 (向量，长度=输出维数)
    %   y      - 当前时刻观测输出 (m x 1)
    %   u      - 当前时刻控制输入 (p x 1)
    % 输出:
    %   hat_x  - 当前时刻状态估计 (n x 1)

    persistent x;
    if isempty(x)
        x = zeros(length(params.A(:,1)), 1);
    end

    % 输出误差
    e = y - params.C * x;

    % 计算非线性函数 fal(e, alpha, delta)
    alpha = params.alpha;
    delta = params.delta;
    e_fal = zeros(size(e));
    for i = 1:length(e)
        if abs(e(i)) <= delta(i)
            e_fal(i) = e(i) / (delta(i)^(1 - alpha(i)));
        else
            e_fal(i) = sign(e(i)) * abs(e(i))^alpha(i);
        end
    end

    % 离散更新
    hat_x = params.A * x + params.B * u + params.L * e_fal;
    x = hat_x;
end

