clc; clear; close all;
%% 1. 观察连续周期方波信号的分解与合成
function output = square_wave(t)
    output = zeros(size(t));

    for i = 1:length(t)

        if mod(t(i), 4) >= 2 && mod(t(i), 4) <= 4
            output(i) = 1;
        else
            output(i) = -1;
        end

    end

end

function f_t = fourier_series_with_square_wave(n)
    % n: 傅里叶级数的最高阶数
    t = linspace(0, 10, 1000);
    f_t = zeros(size(t)); % 初始化傅里叶展开信号
    swave = square_wave(t); % 周期方波信号

    % 计算傅里叶级数的前 n 项（只考虑奇数阶次）
    for k = 1:2:n
        f_t = f_t - (4 / (pi * k)) * sin(k * pi * t / 2);
    end

    figure;
    hold on;
    plot(t, f_t, 'b', 'DisplayName', ['傅里叶级数前 ', num2str(n), ' 次谐波']);
    plot(t, swave, 'r--', 'DisplayName', '周期方波信号');
    title(['傅里叶级数与周期方波信号比较 (n = ', num2str(n), ')'], 'FontWeight', 'bold');
    xlabel('时间 t', 'FontWeight', 'bold');
    ylabel('信号值', 'FontWeight', 'bold');
    legend;
    grid on;
    hold off;
end

fourier_series_with_square_wave(1);
fourier_series_with_square_wave(5);
fourier_series_with_square_wave(49);
fourier_series_with_square_wave(501);
