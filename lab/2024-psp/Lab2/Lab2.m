clc; clear; close all;
% 给定模拟信号 x(t) = A * exp(-alpha * t) * sin(omega1 * t) * u(t)
function output = signal1(input)
    A = 444.128;
    alpha = 50 * sqrt(2) * pi;
    omega1 = 50 * sqrt(2) * pi;
    output = zeros(size(input));
    output(input >= 0) = A .* exp(-alpha .* input(input >= 0)) .* sin(omega1 .* input(input >= 0));
end

% 给定离散信号 x(n) = n + 1, 0 <= n <= 13; 27 - n, 14 <= n <= 26, 0, 其他
function output = signal2(n)
    output = zeros(size(n));

    idx1 = n >= 0 & n <= 13;
    output(idx1) = n(idx1) + 1;

    idx2 = n >= 14 & n <= 26;
    output(idx2) = 27 - n(idx2);
end

% 时域采样
fs1 = 1000; fs2 = 300; fs3 = 200; % 采样频率
Tp = 64e-3; % 观察时间，0.064s
t1 = 0:(1 / fs1):Tp; t2 = 0:(1 / fs2):Tp; t3 = 0:(1 / fs3):Tp; % 采样点

xn1 = signal1(t1); xn2 = signal1(t2); xn3 = signal1(t3); % 离散时域信号
Xk1 = fft(xn1); Xk2 = fft(xn2); Xk3 = fft(xn3); % 离散频域信号

% 离散时域信号的长度
w1 = 0:(2 * pi / length(Xk1)):2 * pi;
w2 = 0:(2 * pi / length(Xk2)):2 * pi;
w3 = 0:(2 * pi / length(Xk3)):2 * pi;
% 在使用（0：ts：T）表示离散时间点时，会多出一个点，需要去掉最后一个点
subplot(3, 2, 1); stem(t1, xn1, "Color", "blue"); title("f_s=1000Hz 采样点图"); xlabel("时间/s");
subplot(3, 2, 2); plot(w1(1:end - 1), abs(Xk1), "Color", "blue"); title("f_s=1000Hz 幅频特性"); xlabel("频率/rad");
subplot(3, 2, 3); stem(t2, xn2, "Color", "blue"); title("f_s=300Hz 采样点图"); xlabel("时间/s");
subplot(3, 2, 4); plot(w2(1:end - 1), abs(Xk2), "Color", "blue"); title("f_s=300Hz 幅频特性"); xlabel("频率/rad");
subplot(3, 2, 5); stem(t3, xn3, "Color", "blue"); title("f_s=200Hz 采样点图"); xlabel("时间/s");
subplot(3, 2, 6); plot(w3(1:end - 1), abs(Xk3), "Color", "blue"); title("f_s=200Hz 幅频特性"); xlabel("频率/rad");

% 频域采样
figure;
x = signal2(0:10000);
X = fft(x);
Xk64 = X(round(linspace(1, length(X), 64)));
Xk32 = Xk64(1:2:end);
Xk16 = Xk32(1:2:end);
xn64 = ifft(Xk64); xn32 = ifft(Xk32); xn16 = ifft(Xk16);

w64 = 0:(2 * pi / length(Xk64)):2 * pi;
w32 = 0:(2 * pi / length(Xk32)):2 * pi;
w16 = 0:(2 * pi / length(Xk16)):2 * pi;

subplot(4, 2, 1); stem(0:32, abs(x(1:33)), "Color", "blue"); title("信号二：三角波序列，长度为 32");
subplot(4, 2, 2); plot(1:length(X), abs(X), "Color", "blue"); title("三角波序列的频谱");
subplot(4, 2, 3); stem(w64(1:end - 1), abs(Xk64), "Color", "blue"); title("信号频域 64 点采样");
subplot(4, 2, 4); stem(1:length(xn64), abs(xn64), "Color", "blue"); title("信号频域 64 点采样 -> 时域");
subplot(4, 2, 5); stem(w32(1:end - 1), abs(Xk32), "Color", "blue"); title("信号频域 32 点采样");
subplot(4, 2, 6); stem(1:length(xn32), abs(xn32), "Color", "blue"); title("信号频域 32 点采样 -> 时域");
subplot(4, 2, 7); stem(w16(1:end - 1), abs(Xk16), "Color", "blue"); title("信号频域 16 点采样");
subplot(4, 2, 8); stem(1:length(xn16), abs(xn16), "Color", "blue"); title("信号频域 16 点采样 -> 时域");

syms t w

A = 444.128; alpha = 50 * sqrt(2) * pi; omega1 = 50 * sqrt(2) * pi;

x_t = A * exp(-alpha * t) * sin(omega1 * t) * heaviside(t);

X_w = simplify(fourier(x_t, t, w));

f = linspace(-200, 200, 1000);
X_val = double(subs(X_w, w, f));
figure;
plot(f, abs(X_val), 'color', 'blue');
title('原连续信号频谱');
xlabel('频率 (rad/s)');
ylabel('|X(w)|');
grid on;
xlim([-200 200]); 
