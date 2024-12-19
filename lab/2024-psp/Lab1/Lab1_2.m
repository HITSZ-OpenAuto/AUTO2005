clc; clear; close all;
%% 2. 观察离散周期方波信号的分解与合成
function [dfs, a_k, b_k] = compute_DFS(sample, N, T_len, T)
    % 从给定的样本数据中计算出离散傅里叶级数的系数和对应的信号
    % sample: 采样信号
    % N: 采样点数
    % T_len: 采样信号的长度
    % T: 采样信号的周期
    dfs = zeros(N, (T_len / T) * N);
    a_k = zeros(1, N);
    b_k = zeros(1, N);

    % 计算 DFS 系数
    for i = 0:N - 1
        a_k(i + 1) = sample(1:N) * cos(2 * pi * i / N * (0:N - 1))' ./ N;
        b_k(i + 1) = -sample(1:N) * sin(2 * pi * i / N * (0:N - 1))' ./ N;
    end

    % 计算 DFS
    for k = 0:N - 1

        for n = 0:(T_len / T) * N
            dfs(k + 1, n + 1) = a_k(k + 1) * cos(2 * pi * k * n / N) - b_k(k + 1) * sin(2 * pi * k * n / N);
        end

    end

end

T = 4;
T_len = 8;
N1 = 60; N2 = 120; N3 = 240;
max_order = 60;
sample1 = square_wave(0:(T / N1):T_len);
sample2 = square_wave(0:(T / N2):T_len);
sample3 = square_wave(0:(T / N3):T_len);
[dfs1, a_k1, b_k1] = compute_DFS(sample1, N1, T_len, T);
[dfs2, a_k2, b_k2] = compute_DFS(sample2, N2, T_len, T);
[dfs3, a_k3, b_k3] = compute_DFS(sample3, N3, T_len, T);

figure;
hold on;
stem(0:(T / N1):T_len, sum(dfs1(1:max_order, :), 1), "Color", "b");
stem(0:(T / N1):T_len, sample1, "Color", "magenta");
xlabel("Time(s)");
ylabel("Amplitude");
title("每个周期内60个采样，60次谐波合成");
legend(["合成", "原信号"], "Location", "southeast");
hold off;

figure;
stem(0:N1 - 1, sqrt(a_k1 .^ 2 + b_k1 .^ 2), "Color", "b");
title("每个周期内60个采样的频谱");
xlabel("n");
ylabel("amplitude");

figure;
hold on;
stem(0:(T / N2):T_len, sum(dfs2(1:120, :), 1), "Color", "b");
stem(0:(T / N2):T_len, sample2, "Color", "magenta");
xlabel("Time(s)");
ylabel("Amplitude");
title("每个周期内120个采样，60次谐波合成");
legend(["合成", "原信号"], "Location", "southeast");
hold off;

figure;
stem(0:N2 - 1, sqrt(a_k2 .^ 2 + b_k2 .^ 2), "Color", "b");
title("每个周期内120个采样的频谱");
xlabel("n");
ylabel("amplitude");

figure;
hold on;
stem(0:(T / N3):T_len, sum(dfs3(1:30, :), 1), "Color", "b");
stem(0:(T / N3):T_len, sample3, "Color", "magenta");
xlabel("Time(s)");
ylabel("Amplitude");
title("每个周期内240个采样，30次谐波合成");
legend(["合成", "原信号"], "Location", "southeast");
hold off;
figure;
hold on;
stem(0:(T / N3):T_len, sum(dfs3(1:60, :), 1), "Color", "b");
stem(0:(T / N3):T_len, sample3, "Color", "magenta");
xlabel("Time(s)");
ylabel("Amplitude");
title("每个周期内240个采样，60次谐波合成");
legend(["合成", "原信号"], "Location", "southeast");
hold off;

figure;
hold on;
stem(0:(T / N3):T_len, sum(dfs3(1:120, :), 1), "Color", "b");
stem(0:(T / N3):T_len, sample3, "Color", "magenta");
xlabel("Time(s)");
ylabel("Amplitude");
title("每个周期内240个采样，120次谐波合成");
legend(["合成", "原信号"], "Location", "southeast");
hold off;

figure;
hold on;
stem(0:(T / N3):T_len, sum(dfs3(1:240, :), 1), "Color", "b");
stem(0:(T / N3):T_len, sample3, "Color", "magenta");
xlabel("Time(s)");
ylabel("Amplitude");
title("每个周期内240个采样，240次谐波合成");
legend(["合成", "原信号"], "Location", "southeast");
hold off;

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
