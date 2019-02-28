clear;clc;close all;
format compact, format short
%% Motor Constants
J = .306      %rotor inertia [kg*m^2]
L = .625E-3   %Terminal Inductance [H]
R = .522      %Terminal Resistance [ohms]
%Speed Constant = 88 [rpm/V]
% Kt = 109E-3 %motor torque constant [Nm/A]
% Ke = ?      %electromotive force [V/(rad/s)]
K = .109      %[V/(rad/s)]
% J/b = 13.6E-3 %mechanical time constant [s]
% L/R = .032625? [ms]
b = 22.5  %motor friction constant [Nm/(rad/s)]
Tload = 0  %load torque
%% Calculating Transfer Functions
ArmatureTFnum = [1]
ArmatureTFden = [L R]
ArmatureTF = tf(ArmatureTFnum,ArmatureTFden)

MotorTFnum = [K]
MotorTFden = [R*J R*b+K^2]
MotorTF = tf(MotorTFnum,MotorTFden)

% bode(MotorTF)  %Plot Bode for Motor Transfer Function
%% Run Simulink
% for i = [1,2,3]
    TL = [0,1.7608,4.7640]  %from Nathan's Calculator - at Tibia: no load, ,Tpose
    Tload = TL(1,i)
    run('DC_Motor')
    SimOut = sim('DC_Motor','StartTime','0','StopTime','10')
    SimOut.who
    tout = SimOut.get('tout');
    DesiredAngle = SimOut.get('simout');
    MotorAngle = SimOut.get('simout1');
    AngularSpeed = SimOut.get('simout2');
    %% Graphing
%     subplot(3,1,i)
    x = tout;
    y = DesiredAngle.Data;
    yyaxis left
    plot(x,y)
    xlim([.9984 1.016])  % changed from xlim([0 10])
    ylim([-.2 1.2])     %changed from ylim([-.5 1.75])
    yy = MotorAngle.Data;
    yyaxis right
    plot(x,yy)
    ylim([-.2 1.2])    %changed from yylim([-.5 1.75])
    title('Multiple Decay Rates')
%     ylabel(y,'Desired Angle') % left y-axis
%     ylabel(yy,'Motor Angle') % right y-axis
    title('Angle Feedback')
    legend('Desired Angle','Motor Angle')
    grid on
% end
%% Extra Stuff
% [hAx,hLine1,hLine2] = plotyy(tout,DesiredAngle.Data,tout,MotorAngle.Data);
% title('Multiple Decay Rates')
% % xlim([0 10])
% % ylim([-.5 .5])
% axis([0 5 0 2])
% % xlabel('Time')
% ylabel(hAx(1),'Speed') % left y-axis
% ylabel(hAx(2),'Position') % right y-axis
% title('Time Position')
% legend('Speed','Motor Position')
% grid on

% subplot(2,1,1)
% plot(tout,Current.Data)
% title('Current')
% grid on
% subplot(2,1,2)
% [hAx,hLine1,hLine2] = plotyy(tout,Speed.Data,tout,Position.Data);
% title('Multiple Decay Rates')
% xlabel('')
% ylabel(hAx(1),'Speed') % left y-axis
% ylabel(hAx(2),'Position') % right y-axis
% title('Time Position')
% legend('Speed','Motor Position')
% grid on

% subplot(3,1,i)
% [hAx,hLine1,hLine2] = plotyy(tout,DesiredAngle.Data,tout,MotorAngle.Data);
% title('Multiple Decay Rates')
% % xlim([0 10])
% % ylim([-.5 .5])
% %     axis(0 5 0 2)
% %     axis([0 5 0 2],[0 5 0 2])  %try seeing "Property Editor" and 'property smthng'
% % xlabel('Time')
% ylabel(hAx(1),'Speed') % left y-axis
% ylabel(hAx(2),'Position') % right y-axis
% title('Time Position')
% legend('Speed','Motor Position')
% grid on