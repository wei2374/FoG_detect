%% load audio file
[data,Fs] = audioread('chimes.wav');

%% plot audio file
data = data(:,1);
dt = 1/Fs;
final_time = size(data,1)*dt;
time_scale =linspace(0,final_time,final_time/dt+1);
figure(1)
subplot(5,1,1)
plot(time_scale,data,'-b');
hold on
title('time scale audio signal')

%% fft and plot
L = final_time/dt;
Y = fft(data);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(5,1,2)
fft_norm = P1/norm(P1);
f = Fs*(0:(L/2))/L;
plot(f,fft_norm);
title('FFT of audio signal')

%% left and right channel
scaling_factor = 1.5;
delay = 0.05;
delay_d = round(delay/dt);
data_left = padarray(data,delay_d,0,'post');
data_right = circshift(data_left,delay_d);

final_time = size(data_left,1)*dt;
time_scale =linspace(0,final_time,final_time/dt);

subplot(5,1,3)
plot(time_scale,data_left,'-b');
hold on
plot(time_scale,data_right,'-r');
hold off
title('right and left channel of audio signal')

%% play audio file
sounds = [data_left,data_right];
sound(sounds,Fs);

%% cross-correlation 
[cc,lags] = xcorr(data_left,data_right);
subplot(5,1,4)
plot(lags,cc);
title('cross correlation between right and left channel of audio signal')

%% add noise
noise = 0.08*randn(size(time_scale));
data_left = data_left+noise';
data_right = data_right+noise';

[cc,lags] = xcorr(data_left,data_right);
subplot(5,1,5)
plot(lags,cc);
title('cross correlation between right and left channel of audio signal with noise')


