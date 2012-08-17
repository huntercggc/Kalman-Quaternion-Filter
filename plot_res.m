%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quaternion Error
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);
plot(QuatError.time, QuatError.signals.values(:,1), 'red','LineWidth',1);
hold on;
plot(QuatError.time, QuatError.signals.values(:,2), 'green','LineWidth',1);
plot(QuatError.time, QuatError.signals.values(:,3), 'blue','LineWidth',1);
plot(QuatError.time, QuatError.signals.values(:,4), 'cyan','LineWidth',1);
legend('q_0','q_1','q_2','q_3');
xlabel('Time [s]');
ylabel('Error');
title('Quaternion error');
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Omega Error
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);
plot(OmegaError.time, OmegaError.signals.values(:,1), 'red','LineWidth',1);
hold on;
plot(OmegaError.time, OmegaError.signals.values(:,2), 'green','LineWidth',1);
plot(OmegaError.time, OmegaError.signals.values(:,3), 'blue','LineWidth',1);
legend('\omega_x','\omega_y','\omega_z');
xlabel('Time [s]');
ylabel('Error [rad/s]');
title('Angular velocity error');
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Omega Error
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3);
plot(BiasError.time, BiasError.signals.values(:,1), 'red','LineWidth',1);
hold on;
plot(BiasError.time, BiasError.signals.values(:,2), 'green','LineWidth',1);
plot(BiasError.time, BiasError.signals.values(:,3), 'blue','LineWidth',1);
legend('\omega_{xb}','\omega_{yb}','\omega_{zb}');
xlabel('Time [s]');
ylabel('Error [rad/s]');
title('Angular velocity bias error');
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Omega
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4);
subplot(2,1,1), plot(OmegaRef.time, OmegaRef.signals.values(:,1), 'red','LineWidth',1);
hold on;
subplot(2,1,1), plot(OmegaRef.time, OmegaRef.signals.values(:,2), 'green','LineWidth',1);
subplot(2,1,1), plot(OmegaRef.time, OmegaRef.signals.values(:,3), 'blue','LineWidth',1);
legend('\omega_x','\omega_y','\omega_z');
xlabel('Time [s]');
ylabel('Angular velocity [rad/s]');
title('Reference angular velocity');
hold off;

subplot(2,1,2), plot(OmegaEst.time, OmegaEst.signals.values(:,1), 'red','LineWidth',1);
hold on;
subplot(2,1,2), plot(OmegaEst.time, OmegaEst.signals.values(:,2), 'green','LineWidth',1);
subplot(2,1,2), plot(OmegaEst.time, OmegaEst.signals.values(:,3), 'blue','LineWidth',1);
legend('\omega_x','\omega_y','\omega_z');
xlabel('Time [s]');
ylabel('Angular velocity [rad/s]');
title('Estimated angular velocity');
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quaternion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(5);
subplot(2,1,1), plot(QuatRef.time, QuatRef.signals.values(:,1), 'red','LineWidth',1);
hold on;
subplot(2,1,1), plot(QuatRef.time, QuatRef.signals.values(:,2), 'green','LineWidth',1);
subplot(2,1,1), plot(QuatRef.time, QuatRef.signals.values(:,3), 'blue','LineWidth',1);
subplot(2,1,1), plot(QuatRef.time, QuatRef.signals.values(:,4), 'cyan','LineWidth',1);
legend('q_0','q_1','q_2','q_3');
xlabel('Time [s]');
title('Reference Quaternion');
hold off;

subplot(2,1,2), plot(QuatEst.time, QuatEst.signals.values(:,1), 'red','LineWidth',1);
hold on;
subplot(2,1,2), plot(QuatEst.time, QuatEst.signals.values(:,2), 'green','LineWidth',1);
subplot(2,1,2), plot(QuatEst.time, QuatEst.signals.values(:,3), 'blue','LineWidth',1);
subplot(2,1,2), plot(QuatEst.time, QuatEst.signals.values(:,4), 'cyan','LineWidth',1);
legend('q_0','q_1','q_2','q_3');
xlabel('Time [s]');
title('Estimated Quaternion');
hold off;