
disp('Loading dataset...');

%load LOG00055_parsed_seg2.mat
load LOG00054_parsed_seg3.mat

% Create the accelerometer and gyroscope dataset
% figure, plot(T, DATA(:,8:10)), legend('acc x','acc y','acc z'),grid on;
acc_ts = timeseries([DATA(:,8:9),DATA(:,10)],DATA(:,1));    %in body frame
% figure, plot(T, DATA(:,5:7).*180/pi), legend('gyro x','gyro y','gyro z'),grid on;  % deg/s  
% figure, plot(T, DATA(:,5:7)), legend('gyro x','gyro y','gyro z'),grid on;          % rad/s
gyro_ts = timeseries([DATA(:,7),DATA(:,6),DATA(:,5)],DATA(:,1));   %[yaw_vel pitch_vel roll_vel] rad/s

%Load the GPS datum
GPS_ts = timeseries(DATA(:,[1 4 7]+19+9),DATA(:,1));
head_yaw_meas = timeseries(DATA(:,4),DATA(:,1));
for i=1:50
    GPS_ts.data(i,:) = [0 0 0];
end

%Load the true path in NED reference system and the true attitude
% figure, plot(T, DATA(:,[1 4 7]+19)),grid on, legend('x','y','z');
% figure, plot(T, DATA(:,2:4).*180/pi), legend('roll','pitch','yaw'),grid on;
pos_NED_ts = timeseries(DATA(:,[1 4 7]+19),DATA(:,1));    %ENU [m]
true_ypr_ts = timeseries([DATA(:,4),DATA(:,3),DATA(:,2)],DATA(:,1));   %[yaw pitch roll] rad

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%% Direct EKF for 6D Pose,  Marco Borraccino %%%%%%%%%%
     %%%%%%%%%   SGN Project, University of Pisa, 2021   %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%