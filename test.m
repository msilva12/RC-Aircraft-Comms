clear, clc, close all

t = 0:0.0001:10;

fc = 2.4e9;

s = cos(2*pi*fc*t);

S = fft(s);

plot(abs(fftshift(S)))
