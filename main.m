%%
format compact, clear, clc, close all
rng default

%% Information Sequence (Bit Stream)
M = 10;
K = 4;
D = 2;
joy1 = round(2^M*rand(K,1)); % 0-1023 (2^M)

%% Encoder
joy1 = dec2bin(joy1,M);

joy1_enc = zeros(K,M);

for p = 1:M
    for q = 1:K
        joy1_enc(q,p) = str2double(joy1(q,p));
    end
end

joy1_enc2 = zeros(K,M/D);

for q = 1:K
    for p = 1:M/D
        joy1_enc2(q,p) = bin2dec(num2str(joy1_enc(q,(1:D)+(p-1)*D)))+1;
    end
end
%% FSK Modulator + Mixer
H = 4;

BW = 1000;

tones = BW*(0:2^D-1)+1;
tones_inc = BW/2^D/2:BW/2^D:BW;

% sbb = zeros(1,(2^M)*K*M/D);
sbb = 0;
p = 1;
t = 0;
leg = '';
while(p<K+1)
    for q = 1:M/D
        sbbf = zeros(1,2^M*2^D*8);
        tmp = tones(mod(p,2^D)+1)+tones_inc(joy1_enc2(p,q));
        sbbf(tmp) = 1024;
        sbb = [sbb ifft(sbbf)];
        leg = [leg; sprintf('msg: %d, freq: %4.f',joy1_enc2(p,q),tmp)];
        t = [t t(end):1/(8*4096):(t(end)+1-1/(8*4096))];
%         legend(leg)
        subplot(212)
        plot(t(2:end),real(sbb(2:end)))
        title('FHSS Time signal')
        xlabel('Time (s)')
        ylabel('Amplitude')
        xlim([t(end)-100/(8*4096) t(end)])
        subplot(211)
        plot([1000 1000],[0 1500],'k')
        hold on
        plot([2000 2000],[0 1500],'k')
        plot([3000 3000],[0 1500],'k')
        plot(sbbf)
        title('FHSS Spectra')
        xlabel('Frequency (Hz)')
        ylabel('Amplitude')
        xlim([0 4096])
%         legend(leg)
%         hold on
        pause(0.75)
    end
    p = p + 1;
end

sbb = sbb(2:end);
pause

%%
figure
spectrogram(sbb,500,1,4096,4096*8,'yaxis');
ylim([0 5])
colorbar off

