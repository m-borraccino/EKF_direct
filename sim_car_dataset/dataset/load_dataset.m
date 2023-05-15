% --------------------     load_dataset.m       -------------------- %
%{
"The Málaga 2009 Robotic Dataset Collection, PARKING_0L"
    J. L. Blanco, F. A. Moreno-Dueñas, University of Málaga, Spain
    for more details see "https://www.mrpt.org/malaga_dataset_2009"
    [24] J.L. Blanco et al., “A collection of outdoor robotic
    datasets with centimeter-accuracy ground truth,”
    Autonomous Robots 27, 4, 2009.

This script loads the sensor data from the "Malaga2009 Dataset"
The text files used are extrapolated from file "parking_0L.rawlog" using
    MRPT program.
%}

%%
disp('Loading dataset...');

T0 = 1226321738.0000;

%Load the true path in ENU reference system and the true attitude
T = readtable('GT_path_vehicle_100Hz.txt','Format','auto');
pos_ENU_ts = timeseries(T{:,2:4},T{:,1}-T0);    %ENU [m]
true_ypr_ts = timeseries(T{:,5:7},T{:,1}-T0);   %[yaw pitch roll]

%Load the accelerometer and gyroscope data from the IMU dataset 
T = readtable('dataset_IMU.txt','Format','auto','PreserveVariableNames',1);
acc_ts = timeseries(T{:,2:4},T{:,1}-T0);    %in body frame
gyro_ts = timeseries(T{:,5:7},T{:,1}-T0);   %[yaw_vel pitch_vel roll_vel]

%Load the GPS RTK datum
T = readtable('dataset_GPS_RTK_FRONT_L.txt','Format','auto','PreserveVariableNames',1);
GPS_RTK_ts = timeseries([T{:,2:3}*180/pi,T{:,4}],T{:,1}-T0);
GPS_RTK_head_ts = timeseries([T{:,8}],T{:,1}-T0);

%Load the GPS low-cost datum
T = readtable('dataset_GPS_NORMAL.txt','Format','auto','PreserveVariableNames',1);
GPS_NORMAL_ts = timeseries([T{:,2:3}*180/pi,T{:,4}],T{:,1}-T0);
GPS_NORMAL_head_ts = timeseries([T{:,8}],T{:,1}-T0);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%% Direct EKF for 6D Pose,  Marco Borraccino %%%%%%%%%%
     %%%%%%%%%   SGN Project, University of Pisa, 2021   %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%