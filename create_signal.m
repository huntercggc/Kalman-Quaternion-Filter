x = linspace(0,1,1000);
x = x';
signal_start = (sin(x*pi-pi/2)+1)/2*0.5;
signal_mid = ones(1000,1)*0.5;
signal_end = -(sin(x*pi-pi/2)-1)/2*0.5;

signal_temp = [signal_start; signal_mid; signal_end];
%signal_temp = [zeros(1500,1); signal_temp; zeros(1000,1); -signal_temp; zeros(1500,1)];
%signal_temp = [signal_temp; -signal_temp];

signal.time = linspace(0,3,length(signal_temp));
signal.signals.values = signal_temp;
signal.signals.dimensions = 1;
signal.signals.label = 'signal';

clear x signal_start signal_mid signal_end signal_temp;