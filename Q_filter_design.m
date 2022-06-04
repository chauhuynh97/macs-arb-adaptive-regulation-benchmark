clear all
close all
%% Q fifigure;
Fs = 800;
Ts = 1/Fs;

bode_opt            = bodeoptions;
bode_opt.FreqUnits  = 'Hz';
bode_opt.FreqScale  = 'Linear';
bode_opt.xlim       = {[0 400]};
bode_opt.PhaseWrapping = 'On';

while 1
    alpha = input('Choose value of alpha:\n   0.865 (default, press ENTER) \n');
    if isempty(alpha)
        alpha        = 0.865;   
    end
    break;
end

omega0 = 2*pi*60*Ts;

num = [-2*(alpha-1)*cos(omega0),alpha^2 - 1];
den = [1,-2*alpha*cos(omega0),alpha^2];

Q = tf(num,den,Ts,'variable','z^-1');
figure;
bodeplot(Q,bode_opt)
grid on,zoom on

num = [2*cos(omega0),-1];
den = [1];

FIR_Q = tf(num,den,Ts,'variable','z^-1');
figure;
bodeplot(FIR_Q,bode_opt)
grid on,zoom on

z = tf('z',Ts);
Q1 = 1 - z^(-1)*Q;
figure;
bodeplot(Q1,bode_opt)
grid on,zoom on