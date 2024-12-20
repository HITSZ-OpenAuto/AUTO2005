clc; clear; close all;
%% 3. 观察连续周期锯齿波信号的分解与合成
function output = jagged_wave(t)
    output = mod(t, 4) / 2 - 1; % 计算锯齿波信号
end

function f_t = fourier_series_with_jagged_wave(max_order)
    % max_order: 傅里叶级数的最高阶数
    T = 4; % 周期
    t = 0:0.01:10; % 时间范围
    jwave = jagged_wave(t); % 周期锯齿波信号

    a_k = zeros(1, max_order); % 傅里叶级数的余弦系数
    b_k = zeros(1, max_order); % 傅里叶级数的正弦系数
    jagged_fourier = zeros(max_order, length(t)); % 傅里叶级数信号

    % 计算 a0
    a0 = integral(@jagged_wave, 0, T) / T;

    % 计算系数 a_k 和 b_k
    for k = 1:max_order
        a_func = @(x) (jagged_wave(x) .* cos(k * 2 * pi / T * x));
        b_func = @(x) (jagged_wave(x) .* sin(k * 2 * pi / T * x));
        a_k(k) = (2 / T) * integral(a_func, 0, T);
        b_k(k) = (2 / T) * integral(b_func, 0, T);
    end

    % 计算傅里叶级数
    for i = 1:length(t)

        for j = 1:max_order
            jagged_fourier(j, i) = a_k(j) * cos(j * 2 * pi / T * t(i)) + b_k(j) * sin(j * 2 * pi / T * t(i));
        end

    end

    % 计算总的傅里叶级数信号
    f_t = a0 + sum(jagged_fourier, 1); % 计算总信号，包括常数项 a0

    figure;
    hold on;
    plot(t, f_t, 'b', 'DisplayName', ['傅里叶级数前 ', num2str(max_order), ' 次谐波']);
    plot(t, jwave, 'r--', 'DisplayName', '周期锯齿波信号');
    title(['傅里叶级数与周期锯齿波信号比较 (max\_order = ', num2str(max_order), ')'], 'FontWeight', 'bold');
    xlabel('时间 t', 'FontWeight', 'bold');
    ylabel('信号值', 'FontWeight', 'bold');
    legend;
    grid on;
    hold off;
end

fourier_series_with_jagged_wave(1);
fourier_series_with_jagged_wave(7);
fourier_series_with_jagged_wave(49);
fourier_series_with_jagged_wave(501);
