clc; clear; close all;
%% 3.1 当采样频率分别为 5Hz，15Jz和40Hz时，信号采样后取128点离散序列，画出离散序列时域波形和频谱幅度谱
% 定义时间变量
fs = 1000; % 采样频率
t = 0:1 / fs:1; % 时间向量，从 0 到 1 秒，步长为 1/fs
f1 = 5; f2 = 9;

% 生成连续时间信号 x(t)
x_t = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t);

% 绘制信号
figure;
plot(t, x_t);
title('连续时间信号 x(t)');
xlabel('时间 (秒)');
ylabel('幅度');
grid on;

sampling_rates = [5, 15, 40];

% 进行采样并绘制结果
for i = 1:length(sampling_rates)
    fs_sample = sampling_rates(i);
    n = 0:127; % 采样点，128个点
    t_sample = n / fs_sample; % 离散时间向量

    % 对信号进行采样
    x_sampled = sin(2 * pi * f1 * t_sample) + sin(2 * pi * f2 * t_sample);

    % 绘制时域图
    figure;
    stem(t_sample, x_sampled, 'filled');
    title(['采样频率为 ', num2str(fs_sample), ' Hz 的离散时域信号']);
    xlabel('时间 (秒)');
    ylabel('幅度');
    grid on;

    % 计算并绘制频谱幅度谱
    X_f = fft(x_sampled);
    X_magnitude = abs(X_f);
    f_axis = (0:127) * (fs_sample / 128); % 对应的频率轴，覆盖 0 到 fs_sample

    figure;
    plot(f_axis, X_magnitude);
    title(['采样频率为 ', num2str(fs_sample), ' Hz 的频谱幅度谱']);
    xlabel('频率 (Hz)');
    ylabel('幅度');
    grid on;
end

%% 3.2 取采样频率为 60Hz 时x(t)的 64 点离散序列，再将其结尾补零加长到 128 点，画出上述两种情况下的离散序列时域波形和频域幅度谱。
clc; clear; close all;

f1 = 5; f2 = 9;

% 采样频率
fs_sample = 60;
n = 0:63; % 64 点采样
t_sample = n / fs_sample; % 离散时间向量

% 对信号进行 64 点采样
x_sampled = sin(2 * pi * f1 * t_sample) + sin(2 * pi * f2 * t_sample);

% 绘制 64 点采样的时域波形
figure;
stem(t_sample, x_sampled, 'filled');
title('采样频率为 60 Hz 的 64 点离散时域信号');
xlabel('时间 (秒)');
ylabel('幅度');
grid on;

% 计算并绘制 64 点频谱幅度谱
X_f_64 = fft(x_sampled);
X_magnitude_64 = abs(X_f_64);
f_axis_64 = (0:63) * (fs_sample / 64); % 频率轴

figure;
plot(f_axis_64, X_magnitude_64);
title('采样频率为 60 Hz 的 64 点频谱幅度谱');
xlabel('频率 (Hz)');
ylabel('幅度');
grid on;

% 零填充至 128 点
x_sampled_padded = [x_sampled, zeros(1, 64)];

% 绘制 128 点补零后的时域波形
t_padded = (0:127) / fs_sample;
figure;
stem(t_padded, x_sampled_padded, 'filled');
title('采样频率为 60 Hz 的 128 点（零填充）离散时域信号');
xlabel('时间 (秒)');
ylabel('幅度');
grid on;

% 计算并绘制 128 点频谱幅度谱
X_f_128 = fft(x_sampled_padded);
X_magnitude_128 = abs(X_f_128);
f_axis_128 = (0:127) * (fs_sample / 128); % 频率轴

figure;
plot(f_axis_128, X_magnitude_128);
title('采样频率为 60 Hz 的 128 点频谱幅度谱');
xlabel('频率 (Hz)');
ylabel('幅度');
grid on;

%% 3.3 取采样频率为 60Hz 时x(t)的 128 点离散序列，画出离散序列时域波形和频域幅度谱，并与（2）中结尾补零、加长到 128 点的序列波形和频谱相比较
clc; clear; close all;

% 定义时间变量
fs = 1000; % 原始采样频率
t = 0:1 / fs:1; % 时间向量，从 0 到 1 秒，步长为 1/fs
f1 = 5; f2 = 9;

% 生成连续时间信号 x(t)
x_t = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t);

% 采样频率
fs_sample = 60;
n = 0:127; % 128 点采样
t_sample = n / fs_sample; % 离散时间向量

% 对信号进行 128 点采样
x_sampled_128 = sin(2 * pi * f1 * t_sample) + sin(2 * pi * f2 * t_sample);

% 绘制 128 点采样的时域波形
figure;
subplot(2, 2, 1);
stem(t_sample, x_sampled_128, 'filled');
title('采样频率为 60 Hz 的 128 点时域信号');
xlabel('时间 (秒)');
ylabel('幅度');
grid on;

% 计算并绘制 128 点频谱幅度谱
X_f_128_sampled = fft(x_sampled_128);
X_magnitude_128_sampled = abs(X_f_128_sampled);
f_axis_128 = (0:127) * (fs_sample / 128); % 频率轴

subplot(2, 2, 2);
plot(f_axis_128, X_magnitude_128_sampled);
title('采样频率为 60 Hz 的 128 点频谱幅度谱');
xlabel('频率 (Hz)');
ylabel('幅度');
grid on;

% 补零后的 128 点序列（使用 64 点补零延长）
x_sampled_64 = x_sampled_128(1:64); % 取前 64 点用于补零
x_sampled_padded = [x_sampled_64, zeros(1, 64)]; % 零填充至 128 点

% 绘制补零后的 128 点时域波形
subplot(2, 2, 3);
t_padded = (0:127) / fs_sample;
stem(t_padded, x_sampled_padded, 'filled');
title('补零后的 128 点时域信号');
xlabel('时间 (秒)');
ylabel('幅度');
grid on;

% 计算并绘制补零后的 128 点频谱幅度谱
X_f_128_padded = fft(x_sampled_padded);
X_magnitude_128_padded = abs(X_f_128_padded);

subplot(2, 2, 4);
plot(f_axis_128, X_magnitude_128_padded);
title('补零后的 128 点频谱幅度谱');
xlabel('频率 (Hz)');
ylabel('幅度');
grid on;

% 绘制时域波形比较
figure;
subplot(2, 1, 1);
hold on;
plot(t_sample, x_sampled_128, '-b', 'DisplayName', '原始 128 点采样');
plot(t_sample, x_sampled_padded, '--r', 'DisplayName', '补零后的 128 点采样');
title('时域波形比较');
xlabel('时间 (秒)');
ylabel('幅度');
legend;
grid on;
hold off;

% 绘制频谱幅度比较
subplot(2, 1, 2);
hold on;
plot(f_axis_128, X_magnitude_128_sampled, '-b', 'DisplayName', '原始 128 点频谱');
plot(f_axis_128, X_magnitude_128_padded, '--r', 'DisplayName', '补零后的 128 点频谱');
title('频谱幅度比较');
xlabel('频率 (Hz)');
ylabel('幅度');
legend;
grid on;
hold off;
