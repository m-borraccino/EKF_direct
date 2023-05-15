% --------------------           init.m             -------------------- %
%{
This file contains the main parameters and constants useful for the whole 
    simulation. Run this file before launch Simulink Model 'EKF_sim.slx' 
%}
% clear; clc; close;
addpath(genpath(pwd));

%% Simulation parameters
type_of_GPS=1;
% Choose up to 4 time intervals with GPS outages 
% Simulation starts at t=0 and ends at t=257
t1_start = 290;
t1_end   = 291;
t2_start = 392;
t2_end   = 392.5;
t3_start = 419;
t3_end   = 420;
t4_start = 438;
t4_end   = 439;
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

run load_dataset2.m

% Sensors parameters
gyro_variance      = 4.8e-2;        %Gyroscope Variance           
bias_gyro_variance = 4e-14;         %Gyroscope Bias Variance
acc_variance       = 4.8e-1;        %Accelerometer Variance
bias_acc_variance  = 4e-10;         %Accelerometer Bias Variance
lambda_xg          = 1e-3;          %Correlation time of Gyroscope Bias
lambda_xa          = 1e-4;          %Correlation time of Accelerometer Bias
vel_variance       = 1e-2;          %Variance for zero velocity constraint


% gyro_variance      = 4.8e-6;        %Gyroscope Variance           
% bias_gyro_variance = 4e-14;         %Gyroscope Bias Variance
% acc_variance       = 4.8e-2;        %Accelerometer Variance
% bias_acc_variance  = 4e-14;         %Accelerometer Bias Variance
% lambda_xg          = 1e-3;          %Correlation time of Gyroscope Bias
% lambda_xa          = 1e-4;          %Correlation time of Accelerometer Bias
% vel_variance       = 1e-2;          %Variance for zero velocity constraint


GPS_variance  = 1e-2;               %Variance of GPS  readings
head_variance = 7e-3;               %Variance of head reafings from GPS 

disp('Dataset loading: done!');

%% System Constants
EKF_DT = 0.02;                  %EKF Period [frequency = 50 Hz]
DT = EKF_DT;
g = 9.81;                       %Gravity Constant

% Initial period of time for initialization task 
init_time = 11;                  %[sec]

% Constant parameters for the SHOE algorithm ([23] for more details)
SHOE_buffer_N  = 100;            
SHOE_threshold = 30;
% SHOE_threshold = 2000;

zero_vel_period = 50000;    %sets this parameter bigger than the 
                            %simulation time to disable zero vel correction

disp('System constants and parameters loaded!');
disp('Ready for the simulation...');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%% Direct EKF for 6D Pose,  Marco Borraccino %%%%%%%%%%
     %%%%%%%%%   SGN Project, University of Pisa, 2021   %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%