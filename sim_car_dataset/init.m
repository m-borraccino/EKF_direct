% --------------------           init.m             -------------------- %
%{
This file contains the main parameters and constants useful for the whole 
    simulation. Run this file before launch Simulink Model 'EKF_sim.slx' 
%}
clear; clc; close;
addpath(genpath(pwd));

%% Simulation parameters

% Set 0 or 1 to choose the type of GPS dataset used
%   1 --> GPS RTK              accuracy of ~cm [4Hz]
%   0 --> DGPS Low-cost        accuracy of ~m  [1Hz]
type_of_GPS = 1;

% Choose up to 4 time intervals with GPS outages 
% Simulation starts at t=0 and ends at t=257
t1_start = 90;
t1_end   = 100;
t2_start = 183;
t2_end   = 193;
t3_start = 203;
t3_end   = 213;
t4_start = 237;
t4_end   = 244;
% Set all parameters to 1 to no consider GPS outages
% t1_start = 1;
% t1_end   = 1;
% t2_start = 1;
% t2_end   = 1;
% t3_start = 1;
% t3_end   = 1;
% t4_start = 1;
% t4_end   = 1;

%% Constants
% Load dataset 
% "The Málaga 2009 Robotic Dataset Collection, PARKING_0L"
% J. L. Blanco, F. A. Moreno-Dueñas, University of Málaga, Spain
% for more details see "https://www.mrpt.org/malaga_dataset_2009" 
addpath('dataset')
addpath('other_functions')
run load_dataset.m
Delta2 = [260.168 -23.8158 1.64305];
   
lat0 = 36.7144590750000006;     
lon0 = -4.4789588283333330;
h0   = 38.8887000000000000;

% Sensors parameters
gyro_variance      = 4.8e-6;        %Gyroscope Variance           
bias_gyro_variance = 4e-14;         %Gyroscope Bias Variance
acc_variance       = 4.8e-2;        %Accelerometer Variance
bias_acc_variance  = 4e-14;         %Accelerometer Bias Variance
lambda_xg          = 1e-3;          %Correlation time of Gyroscope Bias
lambda_xa          = 1e-4;          %Correlation time of Accelerometer Bias
vel_variance       = 1e-2;          %Variance for zero velocity constraint

if type_of_GPS == 1
    GPS_variance  = 1e-2;       %Variance of GPS RTK readings
    head_variance = 7e-3;       %Variance of head reafings from GPS RTK
else
    GPS_variance  = 5;        %Variance of GPS low-cost readings
    head_variance = 5e-2;      %Variance of head readings from GPS low-cost
end

disp('Dataset loading: done!');

%% System Constants
EKF_DT = 0.01;                  %EKF Period [frequency = 100 Hz]
DT = EKF_DT;
g = 9.81;                       %Gravity Constant

% Initial period of time for initialization task 
init_time = 4;                  %[sec]

% Constant parameters for the SHOE algorithm ([23] for more details)
SHOE_buffer_N  = 100;            
SHOE_threshold = 2000;

zero_vel_period = 0.1;

disp('System constants and parameters loaded!');
disp('Ready for the simulation...');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%% Direct EKF for 6D Pose,  Marco Borraccino %%%%%%%%%%
     %%%%%%%%%   SGN Project, University of Pisa, 2021   %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%