% Matlab code
% Comparison of Root-Locus and step response for different controllers type
% P, PD, PI, PID
% clear matlab memory and close all figures
clear all; close all;
% define motor transfer function, G
L = 5.02E-3; R = 41.5; J = 2.21E-6; B = 7.36E-5; K = 0.055;
numG = K; denG = [ (J*R) (R*B)+(K^2) 0];
G = tf(numG, denG);

% P-control
numD = [120]; denD = [1]; D = tf(numD, denD);
subplot(4,2,1); rlocus(series(D,G)); title('P-Control')
cltf = feedback(series(D,G), [1], -1);
hold on; plot(real(roots(cltf.den{:})), imag(roots(cltf.den{:})), 'rx'); hold off;
subplot(4,2,2); step(cltf*10,0.4); title('P-Control Kp = 120'); % amplitude step = 10, time 0.4 s
% PD-control
numD = [1.1 120]; denD = [1]; D = tf(numD, denD);
subplot(4,2,3); rlocus(series(D,G)); title('PD-Control')
cltf = feedback(series(D,G), [1], -1);
hold on; plot(real(roots(cltf.den{:})), imag(roots(cltf.den{:})), 'rx'); hold off;
subplot(4,2,4); step(cltf*10,0.4); title('PD-Control Kp=120 Ki = 1.1');
% PI-control
numD = [1 100]; denD = [1 0]; D = tf(numD, denD);
subplot(4,2,5); rlocus(series(D,G)); title('PI-Control')
cltf = feedback(series(D,G), [1], -1);
hold on; plot(real(roots(cltf.den{:})), imag(roots(cltf.den{:})), 'rx'); hold off;
subplot(4,2,6); step(cltf); title('PI-Control');
% PID-control
numD = conv([1 200+200j], [1 200-200j]); denD = [1 0]; D = tf(numD, denD);
subplot(4,2,7); rlocus(series(D,G)); title('PID-Control')
cltf = feedback(series(D,G), [1], -1);
hold on; plot(real(roots(cltf.den{:})), imag(roots(cltf.den{:})), 'rx'); hold off;
subplot(4,2,8); step(cltf); title('PID-Control');
