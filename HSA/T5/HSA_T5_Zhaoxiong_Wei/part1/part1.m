clear
%% sine signals
sample_f = 1000;
dt = 1/sample_f;
final_time = 3.5;
simulation_time = linspace(0,final_time,final_time/dt+1);

amp1 = 1;
f1 = 50;
amp2 = 0.5;
f2 = 120;

sin1 = amp1*sin(2*pi*f1*(simulation_time));
sin2 = amp2*sin(2*pi*f2*(simulation_time));
sin3 = sin1+sin2;

%% plot sine
figure(1)
subplot(4,1,1)
plot(simulation_time,sin3);
title('sine wave')

%% fft
L = final_time/dt;
Y = fft(sin3);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(4,1,2)
fft_norm = P1/norm(P1);
f = sample_f*(0:(L/2))/L;
plot(f,fft_norm);
title('FFT')

%% rand noise
noise = 1*randn(size(simulation_time));
sin3 = sin3+noise;
subplot(4,1,3)
plot(simulation_time,sin3);
title('sine wave with noise')

%% fft with noise
L = final_time/dt;
Y = fft(sin3);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(4,1,4)
fft_norm = P1/norm(P1);
f = sample_f*(0:(L/2))/L;
plot(f,fft_norm);
title('FFT with noise')
