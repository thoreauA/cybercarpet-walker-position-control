clear all; close all; clc

global T
%% Nonlinear MPC Control of a CyberWalk platform

%% Control Objective
% The walker on the platform has to be recentered at the center (0,0) of
% the platform through acceleration commands. The walker can walk and its
% velocity is estimated by an estimator. The implemented regulator has to
% reject the disturbance which is introduced by the movements of the user.

%% Feedback Control with Nonlinear MPC
% In general, using nonlinear MPC with an accurate nonlinear prediction
% model provides a benchmark performance; that is, the best control
% solution you can achieve. However, in practice, linear MPC control
% solutions, such as adaptive MPC or gain-scheduled MPC, are more
% computationally efficient than nonlinear MPC. If your linear control
% solution can deliver a comparable performance, there is no need to
% implement the nonlinear control solution, especially in a real-time
% environment.
%
% TODO: In the example (openExample('mpc/NonlinearAndGSMPCControlOfAnEthyleneOxidationPlantExample')), 
% you first design a nonlinear MPC controller to obtain
% the benchmark performance. Afterward, you generate several linear MPC
% objects from the nonlinear controller at different operating point using
% the |convertToMPC| function. Finally, you implement gain-scheduled MPC
% using these linear MPC objects and compare the performance.

%% Design of a nonlinear MPC controller
% Create a nonlinear MPC controller with |5| states, |5| output, |2|
% manipulated variable (inputs), and |2| measured disturbance (walker velocity,
% in the x axis and y axis).
nx = 5;
ny = 5;
nlobj = nlmpc(nx, ny,'MV', [1 2],'MD',[3 4]);

%%
% Sample time and the prediction and control horizons of the controller
nlobj.PredictionHorizon = 10;
nlobj.ControlHorizon = 2;
nlobj.Ts = 0.5;
%%
% Objective function coefficients
nlobj.Weights.ManipulatedVariables = [0.001 0.001];
nlobj.Weights.ManipulatedVariablesRate = [0.1 0.1];
nlobj.Weights.OutputVariables = [10 10 0 1 1];
%%
% Constraints on acceleration inputs
nlobj.MV = struct('Min',{-4;-4},'Max',{4;4});
%%
% Prediction continuous-time model, written in file 'CyberWalk.m'
nlobj.Model.StateFcn = "CyberWalk";
nlobj.States(1).Name  = 'x';
nlobj.States(2).Name  = 'y';
nlobj.States(3).Name  = 'theta';
nlobj.States(4).Name  = 'v';
nlobj.States(5).Name  = 'omega';

nlobj.Model.OutputFcn = @(x,u) [x(1);x(2); x(3); x(4); x(5)];
nlobj.OV(1).Name  = 'x';
nlobj.OV(2).Name  = 'y';
nlobj.OV(3).Name  = 'theta';
nlobj.OV(4).Name  = 'v';
nlobj.OV(5).Name  = 'omega';

%%
% Manipulated Variables
nlobj.MV(1).Name = 'a';
nlobj.MV(2).Name = 'a_omega';

%%
% Measured Disturbance
nlobj.MD(1).Name = 'V_w_x';
nlobj.MD(2).Name = 'V_w_y';

%%
% Constraints
nlobj.MV = struct('Min',{-4;-4},'Max',{4;4});
%nlobj.OV = struct('Min',{-10;-10;-5;-5;-5},'Max',{10;10;5;5;5});

%%
% Initial states and inputs
%v_walker = 0.6;
x0 = [1, 0.5, 0, 0, 0];
u0 = [0, 0];
d0 = [0, 0];
condx     = x0(1);
condy     = x0(2);
condtheta = x0(3);
condv     = x0(4);

%%
% Objective function coefficients
nlobj.Weights.ManipulatedVariables = [0.01 0.01];
nlobj.Weights.ManipulatedVariablesRate = [0.1 0.1];
nlobj.Weights.OutputVariables = [10 10 0 1 1];
%%
% Validate the prediction model functions
validateFcns(nlobj, x0, u0, d0);

%% Bounds
% bound on the saturation of omega (due to 1/R going to infinity)
omega_sat = 2; 
% dimension of the platform
dim_platform = 1.4 ; 
% perceptual constraints, w/o the control part that contrasts the
% intentional walker velocity
omega_min_perc = -0.1;
omega_max_perc = 0.1;
v_min_perc = -0.5;
v_max_perc = 0.5;
%{
omega_min_perc = -1;
omega_max_perc = 1;
v_min_perc = -2;
v_max_perc = 2;
%}
%% Observer
k_obsx = 5;
k_obsy = 5;
%% Simulation
open_system('ControlSim')

% Time for the simulation
T = 40;

%% circumference
%
slope_circ = 0.5;
