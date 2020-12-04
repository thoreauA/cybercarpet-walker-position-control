
clear all
clc

%% Nonlinear MPC

nx = 5;
ny = 5;
nu = 2;

nlobj = nlmpc(nx, ny, nu);

nlobj.Model.StateFcn = "CyberWalk";

nlobj.Model.OutputFcn = @(x,u) [x(1);x(2); x(3); x(4); x(5)];

% Prediction horizon
p = 18;
m = 2;
nlobj.PredictionHorizon = p;
nlobj.ControlHorizon = m;
Ts = 0.1;
%nlobj.Ts = Ts;

%% Cost function, standard one is used 
%nlobj.Weights.OutputVariables = [10 10 1 0 0];
%nlobj.Weights.ManipulatedVariablesRate = [0 0];

%% Constraints
nlobj.MV = struct('Min',{-0.5;-0.1},'Max',{0.5;0.1});

% Initial states and inputs
x0 = [4; 1; 0; 0; 0];
u0 = [0; 0];
validateFcns(nlobj, x0, u0, []);

condx     = x0(1);
condy     = x0(2);
condtheta = x0(3);
condv     = x0(4);

%% References
x_ref = [0 0 0 0 0];
