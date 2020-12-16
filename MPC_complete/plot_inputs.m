%% Inputs plot
% In this script a plotting of the platform states is shown
close all; hold off; clf

global T
%% Input variables from the Simulink simulation
%
tt = 0:0.5:T;
a       = out.inputs.signals.values(:,1);
a_omega = out.inputs.signals.values(:,2);

%% Inputs
% plot acceleration inputs
set(gcf,'position',[500,500,800,300])
subplot(1,2,1)
hold on;
grid on;
xlabel('time','FontSize',18)
ylabel('speed (m/s)','FontSize',18)
%axis([0 20 0 40])
stairs(tt,a,'r')

subplot(1,2,2)
hold on;
grid on;
xlabel('time','FontSize',18)
ylabel('omega (rad/s)','FontSize',18)
%axis([0 20 0 40])
stairs(tt,a_omega,'r')
