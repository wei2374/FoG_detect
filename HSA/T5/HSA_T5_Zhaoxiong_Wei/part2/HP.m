%% original signal
amp1 = 1;
f1 = 50;
amp2 = 0.5;
f2 = 500;
fs = 10000;
final_time = 0.1;
dt = 1/fs;
simulation_time = linspace(0,final_time,final_time/dt+1);

sin1 = amp1*sin(2*pi*f1*(simulation_time));
sin2 = amp2*sin(2*pi*f2*(simulation_time));
sin3 = sin1+sin2;

%% analog filter parameters in s plane
num = [3.18e-4,0];
den = [3.18e-4,1];

%% plot sine
figure(1)
subplot(2,1,1)
plot(simulation_time,sin3);
title('sine wave')

%% get discrete filter paramaters in z plane
[numd,dend]=bilinear(num,den,fs);

a0=1;
a1= -0.7285;
b0=0.8641;
b1=-0.8641;

%% data stream filter implementation
Y = zeros(length(sin3));
for i=2:length(Y)
    Y(i) = -a1*(Y(i-1)) + b0*(sin3(i))+b1*(sin3(i-1)) ;
end
    subplot(2,1,2)
plot(simulation_time,Y);
title('filtered sine wave')



