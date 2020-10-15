close all
hold off
clf

x=out.configuration.signals.values(:,1);
y=out.configuration.signals.values(:,2);
theta=out.configuration.signals.values(:,3);
t=out.configuration.time;
v=out.inputs.signals.values(1,:);
omega=out.inputs.signals.values(2,:);

figure(1);
%subplot(2,2,1)
hold on;
axis equal;
set(gca,'fontname','Times','fontsize',12,'fontweight','normal');box on;

% setup unicycle shape

unicycle_size=0.2;
vertices_unicycle_shape=unicycle_size*[[-0.25;-0.5;1/unicycle_size],...
    [0.7;0;1/unicycle_size],[-0.25;0.5;1/unicycle_size]];
faces_unicycle_shape=[1 2 3];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
resolution = 20;
width = 2;
height = 1;
h = resolution*height;
w = resolution*width;
r = [1; zeros((h-2),1); 1];
matrix_occ = [ones(h,1), repmat(r,1,w-2), ones(h,1)];

% empty map
map = binaryOccupancyMap(matrix_occ, resolution);
figure(1)
show(map)
hold all
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% plot unicycle initial configuration

M=[cos(condtheta) -sin(condtheta) condx; sin(condtheta) cos(condtheta)  condy;0 0 1]; 
vertices_unicycle_shape_0=(M*vertices_unicycle_shape)';
vertices_unicycle_shape_0=vertices_unicycle_shape_0(:,1:2);
patch('Faces',faces_unicycle_shape,'Vertices',vertices_unicycle_shape_0,...
    'FaceColor','none','EdgeColor','k','EraseMode','none');

% plot unicycle final configuration

x=out.configuration.signals.values(:,1);
y=out.configuration.signals.values(:,2);
theta=out.configuration.signals.values(:,3);
x_f=x(length(x));
y_f=y(length(x));
theta_f=theta(length(x));

M=[cos(theta_f) -sin(theta_f) x_f; sin(theta_f) cos(theta_f)  y_f;0 0 1];
vertices_unicycle_shape_f=(M*vertices_unicycle_shape)';
vertices_unicycle_shape_f=vertices_unicycle_shape_f(:,1:2);
patch('Faces',faces_unicycle_shape,'Vertices',vertices_unicycle_shape_f,...
    'FaceColor','none','EdgeColor','k','EraseMode','none');

% plot trajectory

plot(x,y,'k')

xlabel('[m]');ylabel('[m]');

% plot velocity inputs

figure(2);
%subplot(4,2,1); hold on;
subplot(2,1,1); hold on;
plot(t,v,'k')
set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
ylabel('[m/s]');
xlabel('[s]');
title('driving velocity')
box on;
range=axis;
incr=0.05;
range(4)=range(4)+(range(4)-range(3))*incr;
axis(range);

%subplot(4,2,3); hold on;
subplot(2,1,2); hold on;
plot(t,omega,'k')
set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
ylabel('[rad/s]');
xlabel('[s]');
title('steering velocity')
box on;
range=axis;
incr=0.05;
range(4)=range(4)+(range(4)-range(3))*incr;
axis(range);