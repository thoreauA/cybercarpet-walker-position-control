function dxdt = CyberWalk(states, inputs)
%% Continuous-time nonlinear dynamic model of a pendulum on a cart
%
% 4 states (x): 
%   cart position (z)
%   cart velocity (z_dot): when positive, cart moves to right
%   angle (theta): when 0, pendulum is at upright position
%   angular velocity (theta_dot): when positive, pendulum moves anti-clockwisely
% 
% 1 inputs: (u)
%   force (F): when positive, force pushes cart to right 
%
% Copyright 2018 The MathWorks, Inc.

%#codegen
%% Obtain x, u and y
% x
x = states(1);
y = states(2);
theta = states(3);
v = states(4);
omega = states(5);
% u
a = inputs(1);
a_omega = inputs(2);
v_w_x = inputs(3);
v_w_y = inputs(4);

%% Compute dxdt
dxdt = [(y*omega -v*cos(theta) + v_w_x);...
    ( -x*omega -v*sin(theta) + v_w_y);...
    omega;...
    a;...
    a_omega];

end
