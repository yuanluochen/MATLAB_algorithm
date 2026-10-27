function MAC = calc_MAC(phi_r, phi_c)
    % 模态置信度判据计算
    % phi_r 参考模态        
    % phi_c 实验对比模态向量
    % *注意* 上述两个向量要是单个模态就是列向量 1 \times N

    % 确保输入是 double 类型，防止精度问题
    phi_r = double(phi_r);
    phi_c = double(phi_c);
    % 向量归一化 <-> 最大值归一化
    for i = 1 : length(phi_r(1, :))
      phi_r(:, i) = phi_r(:, i) ./ max(phi_r(:, i));
    end
    for i = 1 : length(phi_c(1, :))
      phi_c(:, i) = phi_c(:, i) ./ max(phi_c(:, i));
    end
    % MAC计算
    numerator = abs(phi_r' * phi_c).^2;
    
    denom_r = sum(phi_r .* conj(phi_r), 1); 
    denom_c = sum(phi_c .* conj(phi_c), 1);
    
    denominator = denom_r' * denom_c;
    
    MAC = numerator ./ denominator;
end