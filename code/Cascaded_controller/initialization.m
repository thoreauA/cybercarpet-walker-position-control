%% LHI MODULE

clear all
clc

%% observer gains
k_obsx = 5;
k_obsy = 5;
%% controller gains
k     = 1;
k_a   = 2;
%% initial conditions
condx     = 0.0001;
condy     = 0;
condtheta = 0;
v_max     =  0.5;
omega_max =  0.1;
v_square = 0.2;
a_max = 4;
slope_circ = 0.2;


open_system('cascadeControl')
