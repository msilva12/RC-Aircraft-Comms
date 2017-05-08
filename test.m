clear, clc, close all

% fc = 2.4e9;
% 
% fs = fc*4;
% 
% t = 0:1/fs:0.0001;
% 
% s = cos(2*pi*fc*t);
% 
% S = fft(s);
% L = length(S);
% 
% f = fs*(-L/2:L/2-1)/L;
% 
% subplot(211)
% plot(t,s)
% subplot(212)
% plot(f/1e9,abs(S)/L)


sbbf = zeros(1,1024);

sbbf(10) = 512;
sbbf(2) = 512;

sbb = ifft(sbbf);

subplot(211)
plot(sbbf)
subplot(212)
plot(real(sbb))