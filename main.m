%%
format compact, clear, clc, close all
% rng default

%% Information Sequence (Bit Stream)
M = 10;

joy1 = round(1024*rand(1,1)) % 0-1023 (2^M)

%% Encoder
joy1 = dec2bin(joy1,M)

joy1_enc = zeros(1,M);
for p = 1:M
    joy1_enc(p) = str2double(joy1(p));
end

joy1_enc = [bin2dec(num2str(joy1_enc(1:5))) bin2dec(num2str(joy1_enc(6:10)))]+1

%%
H = 32
BW = 10e6; % [Hz] Bandwidth
fc = 5e6 % [Hz]
% fc = (2.4835+2.4)/2 % [Hz] Center Frequency
% Df = (2.4835e9-2.4e9)/H % [Hz] distance between frequencies
Df = BW/H;
Tc = 1/BW; % [s] Signal Length
fs = 20e6;
Ts = 1/fs; % [s] Signaling interval

tones = (-H/2:H/2-1)'.* Df

joy1_enc_sbbf = zeros(1,fs);

joy1_enc_sbbf(tones(joy1_enc)-tones(1)+1) = ones(1,M/5);

f = (-fs/2:fs/2-1);
plot(f,fftshift(joy1_enc_sbbf))


%% FSK Modulator

%% Mixer

%% Channel
