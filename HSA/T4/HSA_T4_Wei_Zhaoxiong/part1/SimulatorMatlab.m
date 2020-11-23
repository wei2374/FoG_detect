clear
close all
clc

%% Initialization:

% Maxon DCX19S (24V version):
beta = 0.7e-6;        % Friction coefficient found heuristically (DO NOT CHANGE)

% ...
% TODO (T.1.1): complete with the required model parameters you find on the
%% data-sheet
J = 2.72e-7; %Rotor Inertia
K_t = 35.6e-3; %Torque Constant
R_r = 22.8; %Rotor winding Resistance
L_r = 1.32e-3; %Rotor winding Inductance
K_v = 268*2*pi/60;% Velocity Constant
K_e = 1/K_v;
t_s = 37.5e-3;
w=0;
i_r=0;
V_r = 24;%Constant input voltage 24V

% TODO (T.1.1): complete with the state space DC-motor model:
%% state
A_dc = [-beta/J,K_t/J;-1/(L_r*K_v),-R_r/L_r];
B_dc = [-1/J ,0;0,1/L_r];
C_dc = [1,0];


% TODO (T.1.1): initialize your state vectors here
%x = [w,i_r];
%y = [0,0];

%% Main simulation loop:

% Function handle for dynamic simulation:
DCmotorDynamics = @(State, controlInput) dcMotorDynamics(State, controlInput, A_dc, B_dc);

%% T1.2
dt = 1e-6; % Timestamp of the simulator [s]
finalTime = 1.0; % Final time of the simulation [s]
simulationTime = linspace(0,finalTime,finalTime/dt+1);
numEpochs = numel(simulationTime);

V_r = 0*(0.5+sin(20*pi*simulationTime))+24;
%% 1 Vr=24V,t_load=0
%t_load = 0*(0.5+sin(20*pi*simulationTime));

%% 2 Vr=24V,t_load=t_s
%t_load = t_s+0*(0.5+sin(20*pi*simulationTime));

%% 3 Vr=24V sine wave t_load
%t_load = t_s*(0.5+sin(20*pi*simulationTime));

%% 4 PWM V_r 100Hz
%PWM_signal = PWM_generator(100,24,0.6);
%V_r = PWM_signal;
%t_load = t_s+0*(0.5+sin(20*pi*simulationTime));

%% 5 PWM V_r 40kHz
PWM_signal = PWM_generator(40000,24,0.6);
V_r = PWM_signal;
t_load = t_s/7+0*(0.5+sin(20*pi*simulationTime));

%%
x_k = zeros(2,numEpochs); % State
y_k = zeros(1,numEpochs); % Measurement 
P_k = zeros(1,numEpochs); % Power
P_m = zeros(1,numEpochs); % Mechanical Power
P_e = zeros(1,numEpochs); % Electrical Power
u = [0;0];
t0 = 4.65e-4+0*(0.5+sin(20*pi*simulationTime));

figure(2)
H_v = tf([K_t],[L_r*J,R_r*J+beta*L_r,K_t*K_e+R_r*beta]);
bode(H_v);
title('voltage-to-velocity')
figure(3)
H_t = tf([K_t*J,beta*K_t],[L_r*J,(R_r*J+beta*L_r),(K_t*K_e+R_r*beta)]);
bode(H_t);
title('voltage-to-torque')

for simulationEpoch = 2:numEpochs
    % TODO (T.1.1): Call the dynamic simulation routine here and fill the
    % required data fields
    u = [t_load(:,simulationEpoch);V_r(:,simulationEpoch)];
    x_k(:,simulationEpoch+1) = rk4_IntegrationStep(DCmotorDynamics,x_k(:,simulationEpoch),u,dt);
    y_k(:,simulationEpoch) = C_dc * x_k(:,simulationEpoch);
    P_e(:,simulationEpoch) = V_r(:,simulationEpoch)* x_k(2,simulationEpoch);    
    P_m(:,simulationEpoch) =  (t_load(:,simulationEpoch)-t0(:,simulationEpoch)).*x_k(1,simulationEpoch);
    eff(:,simulationEpoch) = P_m(:,simulationEpoch)/P_e(:,simulationEpoch);
end

vel = y_k.*60/(2*pi); % Noisy measurement of rotation velocity in [rpm]

%% Plot Functions:

% TODO (T.1.2): plot the required quantities
figure(1)
subplot(3,2,1)
stairs(simulationTime,V_r);
title('voltage Vr')

subplot(3,2,2)
stairs(simulationTime,vel);
title('velocity w')

subplot(3,2,3)
stairs(simulationTime,x_k(2,1:end-1));
title('current i_r')

subplot(3,2,4)
stairs(simulationTime,P_e)
title('power Pe')

subplot(3,2,5)
stairs(simulationTime,P_m)
title('power Pm')

subplot(3,2,6)
stairs(simulationTime,eff);
title('efficiency')




%% Simulation Routines:

function xdot_k = dcMotorDynamics(x_km1, u_km1, A, B)
% TODO (T.1.1.1)
xdot_k = 0;
xdot_k = A*x_km1+B*u_km1;
end

function noisyState = noisyMeasurement(State, sd)

% This function adds Gaussian noise with a standard deviation sd to the measured quantity.

noisyState = State + diag(sd)*randn(size(State));

end

function x_next = rk4_IntegrationStep(ode_fun,x,u,h)

% Runge-Kutta RK4 integration step. ode_fun is a function handle.

k1 = ode_fun(x,u);
k2 = ode_fun(x+h/2.*k1,u);
k3 = ode_fun(x+h/2.*k2,u);
k4 = ode_fun(x+h.*k3,u);
x_next = x + h/6.*(k1+2*k2+2*k3+k4);

end


%% PWM Functions:
function PWM_signal = PWM_generator(f,V_r, duty_cycle)
dt = 1e-6; % Timestamp of the simulator [s]
finalTime = 1; % Final time of the simulation [s]
simulationTime = linspace(0,finalTime,finalTime/dt+1);

Epochs = finalTime/dt;
Cycles = f/finalTime;
positives = duty_cycle*Epochs/Cycles;
N = Epochs/Cycles;
%PWM_signal = zeros(1,Epochs);
for i=1:Cycles+1
    PWM_signal(1+(i-1)*N:positives+(i-1)*N) = V_r;
end
PWM_signal = PWM_signal(1:Epochs+1);
end
