%% Original signal generation
amp1 = 1;
f1 = 50;

amp2 = 0.5;
f2 = 500;

amp3 = 1;
f3 = 1000;

fs = 10000;
final_time = 0.1;
dt = 1/fs;
simulation_time = linspace(0,final_time,final_time/dt+1);


sin1 = amp1*sin(2*pi*f1*(simulation_time));
sin2 = amp2*sin(2*pi*f2*(simulation_time));
sin4 = amp3*sin(2*pi*f3*(simulation_time));

sin3 = sin1+sin2+sin4;

%% Analog filter s plane parameters
num = [7.9577e-4,0];
den = [1.5831e-7,9.9472e-4,1];

%% digital filter z plane parameters
[numd,dend]=bilinear(num,den,fs);

%% plot sine
figure(1)
subplot(2,1,1)
plot(simulation_time,sin3);
title('original sine wave')

%% plot filtered signal
a0=1;
a1= -1.4684;
a2 = 0.5304;

b0=0.1642;
b1=-2.2e-16;
b2=-0.1642;

Y = zeros(length(sin3));

%% data stream filter
for i=3:length(Y)
    Y(i) = -a1*(Y(i-1))-a2*(Y(i-2)) + b0*(sin3(i))+b1*(sin3(i-1))+b2*(sin3(i-2)) ;
end
subplot(2,1,2)
plot(simulation_time,Y);
title('filtered sine wave')

%% plot digital filter bode plot
[h, f] = freqz(numd,dend,5000, fs);
figure(2); clf();
subplot(211); semilogx(f,20*log10(abs(h))); hold on
plot([.1, 1000], [-3 -3],'r'); 
grid on; ylim([-40,1]); ylabel('gain (db)'); xlim([.1, fs/2]);
subplot(212); semilogx(f, angle(h)*180/pi); 
grid on; ylabel('phase(rad)'); xlim([.1, fs/2]); xlabel('frequency(Hz)');




