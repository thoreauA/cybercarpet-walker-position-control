%% States plot
% In this script a plotting of the platform states is shown
close all; hold off; clf

%% Input variables from the Simulink simulation
%
x       = out.configuration.signals.values(:,1);
y       = out.configuration.signals.values(:,2);
theta   = out.configuration.signals.values(:,3);
theta_w   = out.configuration.signals.values(:,6);
v       = out.configuration.signals.values(:,4);
omega   = out.configuration.signals.values(:,5);

t       = out.configuration.time;

%% States
% Plot states of the platform
set(gcf,'position',[400,300,1200,800])
subplot(2,2,1)
hold on;
grid on;
xlabel('time','FontSize',18)
ylabel('postition (m)','FontSize',18)
%axis([0 20 0 40])
plot(t, x, 'r')
plot(t, y, 'b')
legend('x','y')

subplot(2,2,2)
hold on;
grid on;
xlabel('time','FontSize',18)
ylabel('orientation (rad)','FontSize',18)
%axis([0 20 0 40])
plot(t,theta,'b')
plot(t,theta_w,'r')
legend('theta', 'theta walker')

subplot(2,2,3)
hold on;
grid on;
xlabel('time','FontSize',18)
ylabel('speed (m/s)','FontSize',18)
%axis([0 20 0 40])
plot(t,v,'b')

subplot(2,2,4)
hold on;
grid on;
xlabel('time','FontSize',18)
ylabel('omega (rad/s)','FontSize',18)
%axis([0 20 0 40])
plot(t,omega,'b')













