clc; clear; close all;
%% 用 FFT 计算下列两个离散序列的线性卷积，在绘图窗口绘制这两个离散序列及其卷积后序列的幅度谱，分析幅度谱之间的关系
x1 = zeros(1, 15);
x2 = zeros(1, 15);
x3 = zeros(1, 15);
x4 = zeros(1, 15);
n = 1:20000;

% 生成序列 x1
x1(1:5) = 1:5;
x1(6:10) = 5:-1:1;

% 绘制序列 x1 及其 FFT
subplot(4, 2, 1);
stem(x1);
title('序列 x1');

x1_fft = fft(x1, 20000);
subplot(4, 2, 2);
plot(n, abs(x1_fft));
title('x1 的 FFT');

% 生成序列 x2
x2(1:6) = 2 .^ (0:5);
x2(7:12) = -2 .^ (0:5);

% 绘制序列 x2 及其 FFT
subplot(4, 2, 3);
stem(x2);
title('序列 x2');

x2_fft = fft(x2, 20000);
subplot(4, 2, 4);
plot(n, abs(x2_fft));
title('x2 的 FFT');

% 计算卷积后幅度谱及序列

z2 = conv(x1, x2);
z2_fft = fft(z2, 20000);
subplot(4, 2, 5);
stem(1:length(z2), z2);
title('线性卷积后序列');
subplot(4, 2, 6);
plot(n, abs(z2_fft));
title('线性卷积后幅度谱');

z = x1_fft .* x2_fft;
z1 = ifft(z);
subplot(4, 2, 7);
stem(1:30, z1(1:30));
title('圆周卷积后序列');
subplot(4, 2, 8);
plot(n, abs(z));
title('圆周卷积后幅度谱');

figure;

% 生成序列 x3
x3(1:7) = 0.8 .^ (0:6);
x3(8:12) = 4:8;

% 绘制序列 x3 及其 FFT
subplot(4, 2, 1);
stem(x3);
title('序列 x3');

x3_fft = fft(x3, 20000);
subplot(4, 2, 2);
plot(n, abs(x3_fft));
title('x3 的 FFT');

% 生成序列 x4
x4(1:5) = -1:3;
x4(6:13) = -0.6 .^ (0:7);

% 绘制序列 x4 及其 FFT
subplot(4, 2, 3);
stem(x4);
title('序列 x4');

x4_fft = fft(x4, 20000);
subplot(4, 2, 4);
plot(n, abs(x4_fft));
title('x4 的 FFT');

% 计算卷积后幅度谱及序列
o_2 = conv(x3, x4);
o_2_fft = fft(o_2, 20000);
subplot(4, 2, 5);
stem(1:length(o_2), o_2);
title('线性卷积后序列');
subplot(4, 2, 6);
plot(n, abs(o_2_fft));
title('线性卷积后幅度谱');

o = x3_fft .* x4_fft;
o1 = ifft(o);
subplot(4, 2, 7);
stem(1:30, o1(1:30));
title('圆周卷积后序列');
subplot(4, 2, 8);
plot(n, abs(o));
title('圆周卷积后幅度谱');
