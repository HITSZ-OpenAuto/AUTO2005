close all; clear; clc;
%% 1. 模拟低通滤波器设计
set(0, 'DefaultAxesFontSize', 12);
set(0, 'DefaultTextFontSize', 12);
Wp = 300; % 通带截止频率
Ws = 500; % 阻带截止频率
Rp = 3; % 通带最大衰减
Rs = 20; % 阻带最小衰减
[n, Wn] = buttord(Wp, Ws, Rp, Rs, 's'); % 计算巴特沃斯滤波器的阶数和截止频率
[b, a] = butter(n, Wn, 'low', 's'); % 低通滤波器设计
[H, W] = freqs(b, a);
plot(W, 20 * log10(abs(H)));
xlabel('模拟频率/（rads/s）');
ylabel('幅度/dB');
title('模拟低通滤波器的幅频特性');
axis([0 600 -30 8]);
line([300 300], ylim, 'Color', 'b', 'LineStyle', ':', 'LineWidth', 1);
line([500 500], ylim, 'Color', 'b', 'LineStyle', ':', 'LineWidth', 1);
grid on;

[y, t] = impulse(tf(b, a), 0:0.001:0.1); % 低通滤波器的冲激响应
figure;
plot(t, y);
xlabel('时间(s)');
ylabel('输出');
title('模拟低通滤波器的冲激响应');
grid on;
