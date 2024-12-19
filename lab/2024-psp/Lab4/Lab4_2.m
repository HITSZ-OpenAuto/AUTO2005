close all; clear; clc;
%% 2. 数字低通滤波器设计
set(0, 'DefaultAxesFontSize', 12);
set(0, 'DefaultTextFontSize', 12);
Wp = 0.4; % 数字通带截止频率（rad)
Ws = 0.8; % 数字阻带截止频率（rad)
Rp = 3; % 通带最大衰减（dB）
Rs = 15; % 阻带最小衰减（dB）
fs = 100; % 采样频率（Hz）

% 使用buttord设计模拟低通滤波器的阶数和截止频率
% 将数字频率转换为模拟频率（rad/s）
Wp_analog = Wp * fs;
Ws_analog = Ws * fs;
[N, Wn] = buttord(Wp_analog, Ws_analog, Rp, Rs, 's');
[b_analog, a_analog] = butter(N, Wn, 's'); % 设计模拟Butterworth滤波器

% 将模拟滤波器转换为数字滤波器，采用冲激响应不变法
[b_digital, a_digital] = impinvar(b_analog, a_analog, fs);

% 计算幅频特性
figure;
[H, f] = freqz(b_digital, a_digital); % 计算频率响应
f_Hz = f * fs / (2 * pi); % 将频率转换为 Hz
plot(f_Hz, 20 * log10(abs(H))); % 绘制幅频特性，将幅度转换为分贝
line(xlim, [-3 -3], 'Color', 'b', 'LineStyle', ':', 'LineWidth', 1);
line(xlim, [-15 -15], 'Color', 'b', 'LineStyle', ':', 'LineWidth', 1);
xlabel('频率 (Hz)');
ylabel('幅度 (dB)');
title('数字低通滤波器的幅频特性（冲激响应不变法）');
grid on;
% 计算脉冲响应
figure;
impz(b_digital, a_digital, 30); % 绘制脉冲响应
xlabel('样本点数');
ylabel('幅度');
title('数字低通滤波器的脉冲响应（冲激响应不变法）');
grid on;

% 使用buttord设计模拟低通滤波器的阶数和截止频率
% 将数字频率转换为模拟频率（rad/s）
Wp_analog = 2 * fs * tan(Wp / 2);
Ws_analog = 2 * fs * tan(Ws / 2);
[N, Wn] = buttord(Wp_analog, Ws_analog, Rp, Rs, 's');
[b_analog, a_analog] = butter(N, Wn, 's'); % 设计模拟Butterworth滤波器

% 将模拟滤波器转换为数字滤波器，采用双线性变换法
[b_digital, a_digital] = bilinear(b_analog, a_analog, fs);
% 计算幅频特性
figure;
[H, f] = freqz(b_digital, a_digital); % 计算频率响应
f_Hz = f * fs / (2 * pi); % 将频率转换为 Hz
plot(f_Hz, 20 * log10(abs(H))); % 绘制幅频特性，将幅度转换为分贝
line(xlim, [-3 -3], 'Color', 'b', 'LineStyle', ':', 'LineWidth', 1);
line(xlim, [-15 -15], 'Color', 'b', 'LineStyle', ':', 'LineWidth', 1);
xlabel('频率 (Hz)');
ylabel('幅度 (dB)');
title('数字低通滤波器的幅频特性（双线性变换法）');
grid on;
% 计算脉冲响应
figure;
impz(b_digital, a_digital, 30); % 绘制脉冲响应
xlabel('样本点数');
ylabel('幅度');
title('数字低通滤波器的脉冲响应（双线性变换法）');
grid on;
