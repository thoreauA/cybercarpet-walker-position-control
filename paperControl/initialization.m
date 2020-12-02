%% LHI MODULE

clear all
clc

%% system
%{
syms x(t) y(t) theta(t) 
%assume([x(t) y(t) theta(t) v(t) omega(t)], 'real')
states = [x; y; theta];
%inputs = [v; omega];

k= 10;
v = k*(x^2 + y^2)/(x*cos(theta)+y*sin(theta));
omega = k*(y*cos(theta)-x*sin(theta))*sign(x*cos(theta)+y*sin(theta));

xdot = diff(x) == y*omega -v*cos(theta);
ydot = diff(y) == -x*omega -v*sin(theta);
thetadot = diff(theta) == omega;
%}

k         = 4;
k_omega   = 0.3;
condx     = 1;
condy     = 0;
condtheta = 0.2;

%nonholonomicConstraint = sin(theta)*xdot -cos(theta)*ydot -(x*cos(theta)+y*sin(theta))*thetadot == 0;

%{
odes = [xdot; ydot; thetadot];
conds = [condx; condy; condtheta];%; nonholonomicConstraint]

S = dsolve(odes,conds)
k*(u(1)^2 +u(2)^2)*(u(1)*cos(u(3))+u(2)*sin(u(3)))
k*(u(2)*cos(u(3))-u(1)*sin(u(3)))*sign(u(1)*cos(u(3))+u(2)*sin(u(3)))
%}
