
%% Animation of the walker
% Thhis script shows an animation of the control NLMPC for the CyberCarpert
% platform. Two triangles are shown for initial and final configurations
% of the walker (position and orientation), then the motion of the walker 
% is shown. It is represented by a red circle for the position (x,y) and a
% red segment indicates the orientation. On the right it is shown the
% walker velocity in x and y axis.

%%
close all
hold off
clf

%% Input variables from the Simulink simulation
%
x       = out.configuration.signals.values(:,1);
y       = out.configuration.signals.values(:,2);
theta_w   = out.configuration.signals.values(:,6);

t       = out.configuration.time;

V_x_w   = out.walker.signals.values(:,1);
V_y_w   = out.walker.signals.values(:,2);

figure(1)
set(gcf,'position',[100,100,1800,700])
subplot(1,2,1)
%axis('square')
%% Body frame, represented by a triangle
%%
% Shape
unicycle_size=0.2;
vertices_unicycle_shape=unicycle_size*[[-0.25;-0.5;1/unicycle_size],...
    [0.7;0;1/unicycle_size],[-0.25;0.5;1/unicycle_size]];
faces_unicycle_shape=[1 2 3];

%%
% Plot unicycle initial configuration
M=[cos(condtheta) -sin(condtheta) condx; sin(condtheta) cos(condtheta)  condy;0 0 1]; 
vertices_unicycle_shape_0=(M*vertices_unicycle_shape)';
vertices_unicycle_shape_0=vertices_unicycle_shape_0(:,1:2);
patch('Faces',faces_unicycle_shape,'Vertices',vertices_unicycle_shape_0,...
    'FaceColor','none','EdgeColor','b','EraseMode','none','linewidth',1.5);

%%
% Plot unicycle final configuration
x_f     = x(length(x));
y_f     = y(length(y));
theta_f = theta_w(length(theta_w));
M=[cos(theta_f) -sin(theta_f) x_f; sin(theta_f) cos(theta_f)  y_f;0 0 1];
vertices_unicycle_shape_f=(M*vertices_unicycle_shape)';
vertices_unicycle_shape_f=vertices_unicycle_shape_f(:,1:2);
patch('Faces',faces_unicycle_shape,'Vertices',vertices_unicycle_shape_f,...
    'FaceColor','none','EdgeColor','b','EraseMode','none','linewidth',1.5);

%% Trajectory
% plot trajectory
hold on;
grid on;
set(gca,'fontname','Times','fontsize',12,'fontweight','normal','GridLineStyle','--');box on;
%plot(x, y, 'k', 'linewidth', 1.2)
xlabel('[m]');ylabel('[m]');

%%
%Plot dimension of the platform
x1=-1.5;
x2=1.5;
y1=1.5;
y2=-1.5;
x_platform = [x1, x2, x2, x1, x1];
y_platform = [y1, y1, y2, y2, y1];
plot(x_platform, y_platform, 'b--', 'LineWidth', 1);
plot(0,0,'b*');

%%
pause(0.5)
subplot(1,2,1)
h = animatedline;
axis([-2, 2, -2, 2]);
subplot(1,2,2)
hold on;
grid on;
h1 = animatedline;
h1.Color = 'r';
h2 = animatedline;
h2.Color = 'b';
axis([0 40 -3 3]); 
set(gca,'fontname','Times','fontsize',12,'fontweight','normal','GridLineStyle','--');box on;
%plot(x, y, 'k', 'linewidth', 1.2)
ylabel('[m/s]');xlabel('[seconds]');
for i = 1:length(x)
    linkx(i,:) = [0:0.02:0.5]*cos(theta_w(i))+x(i);
    linky(i,:) = [0:0.02:0.5]*sin(theta_w(i))+y(i);
    subplot(1,2,1)
    addpoints(h,x(i),y(i));
    subplot(1,2,1)
    aux = plot(x(i),y(i),'r--o','linewidth',2); 
    subplot(1,2,1)
    aux1 = plot(linkx(i,:),linky(i,:),'g','linewidth',1.5);
    
    subplot(1,2,2)
    addpoints(h1, t(i), V_x_w(i));
    subplot(1,2,2)
    addpoints(h2, t(i), V_y_w(i));
    legend('V walker in x','V walker in y')
    
    pause(0.004)  % the timing is ten times less then the real one (0.5) 
    drawnow
    
    delete(aux1)
    delete(aux)
end
%{
t       = out.configuration.time;

V_x_w   = out.walker.signals.values(:,1);
V_y_w   = out.walker.signals.values(:,2);
hold on;
grid on;
axis([0 40 -3 3]); 
set(gcf,'position',[400,300,1000,800])
set(gca,'fontname','Times','fontsize',12,'fontweight','normal','GridLineStyle','--');box on;
plot(t,V_x_w,'r')
plot(t,V_y_w,'b')
legend('V walker along x', 'V walker along y','FontSize',18)
ylabel('[m/s]');xlabel('[seconds]');
%}
