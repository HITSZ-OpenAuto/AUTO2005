%% 通过 FFT 分析以下离散时间序列，并在绘图窗口绘制幅度谱和相位谱。
clc; clear; close all;
x = zeros(1, 10);
y = zeros(1, 10);
n = 1:10000;
% 三角波序列
x(1:5) = 1:5;
x(6:9) = 4:-1:1;

% 绘制三角波序列及其FFT
subplot(2, 3, 1);
stem(x);
title('三角波序列');

x1 = fft(x, 10000);
subplot(2, 3, 2);
plot(n, abs(x1));
title('三角波FFT幅值');
subplot(2, 3, 3);
plot(n, 180 / pi * angle(x1));
title('三角波FFT相位');

% 生成矩形序列
y(1:7) = 1;

% 绘制矩形序列及其FFT
subplot(2, 3, 4);
stem(y);
title('矩形序列');

y1 = fft(y, 10000);
subplot(2, 3, 5);
plot(n, abs(y1));
title('矩形序列FFT幅值');
subplot(2, 3, 6);
plot(n, 180 / pi * angle(y1));
title('矩形序列FFT相位');
