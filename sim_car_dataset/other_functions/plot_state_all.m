%close
%%      

f=figure (9)
subplot(3,2,1);
hold on
title('EKF Euler Angles EKF')
axis on
grid on
xlabel('time [s]')
ylabel('[rad]')
xlim([0 out.ypr_rad_es.Length/100])
plot(out.ypr_rad_es.time,out.ypr_rad_es.data(:,1),'r-');
plot(out.ypr_rad_es.time,out.ypr_rad_es.data(:,2),'b-');
plot(out.ypr_rad_es.time,out.ypr_rad_es.data(:,3),'g-');

subplot(3,2,2); 
hold on
title('EKF Linear Velocity')
axis on
grid on
xlabel('time [s]')
ylabel('[m/s]')
xlim([0 out.ypr_rad_es.Length/100])
plot(out.vel_lin_es.time,out.vel_lin_es.data(:,1),'g-');
plot(out.vel_lin_es.time,out.vel_lin_es.data(:,2),'b-');
plot(out.vel_lin_es.time,out.vel_lin_es.data(:,3),'r-');

subplot(3,2,3); 
hold on
title('EKF Angular Velocity')
axis on
grid on
xlabel('time [s]')
ylabel('[rad/s]')
xlim([0 out.ypr_rad_es.Length/100])
plot(out.vel_ang_es.time,out.vel_ang_es.data(:,3),'g-');
plot(out.vel_ang_es.time,out.vel_ang_es.data(:,2),'b-');
plot(out.vel_ang_es.time,out.vel_ang_es.data(:,1),'r-');

subplot(3,2,4); 
hold on
title('EKF Linear Acceleration')
axis on
grid on
xlabel('time [s]')
ylabel('[m/s^2]')
xlim([0 out.ypr_rad_es.Length/100])
plot(out.acc_lin_es.time,out.acc_lin_es.data(:,1),'g-');
plot(out.acc_lin_es.time,out.acc_lin_es.data(:,2),'b-');
plot(out.acc_lin_es.time,out.acc_lin_es.data(:,3),'r-');

subplot(3,2,5); 
hold on
title('EKF Gyro Bias')
axis on
grid on
xlabel('time [s]')
ylabel('[rad/s]')
xlim([0 out.ypr_rad_es.Length/100])
plot(out.bias_gyro_es.time,out.bias_gyro_es.data(:,1),'g-');
plot(out.bias_gyro_es.time,out.bias_gyro_es.data(:,2),'b-');
plot(out.bias_gyro_es.time,out.bias_gyro_es.data(:,3),'r-');

subplot(3,2,6); 
hold on
title('EKF Accelerometer Bias')
axis on
grid on
xlabel('time [s]')
ylabel('[m/s^2]')
xlim([0 out.ypr_rad_es.Length/100])
plot(out.bias_acc_es.time,out.bias_acc_es.data(:,1),'g-');
plot(out.bias_acc_es.time,out.bias_acc_es.data(:,2),'b-');
plot(out.bias_acc_es.time,out.bias_acc_es.data(:,3),'r-');

f.Position=[302 39 840 645];

fname = strcat( pwd,'\graphics' );
saveas(figure(9), fullfile(fname, 'EKF_all'), 'png')
%%

f=figure (10)
subplot(1,2,1);
hold on
title('SHOE Attitude Updates')
axis on
grid on
xlabel('time [s]')
xlim([0 out.flag_vect.Length/100])
plot(out.flag_vect.time,out.flag_vect.data(2,:),'b-');


subplot(1,2,2); 
hold on
title('GPS Updates')
axis on
grid on
xlabel('time [s]')
xlim([0 out.flag_vect.Length/100])
plot(out.flag_vect.time,out.flag_vect.data(3,:),'b-');

f.Position=[302 118 840 78];
fname = strcat( pwd,'\graphics' );
saveas(figure(10), fullfile(fname, 'EKF_all_flag'), 'png')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=figure (11)
subplot(2,2,1);
hold on
title('EKFnb Euler Angles')
axis on
grid on
xlabel('time [s]')
ylabel('[rad]')
xlim([0 out.ypr_rad_es_nb.Length/100])
plot(out.ypr_rad_es_nb.time,out.ypr_rad_es_nb.data(:,1),'r-');
plot(out.ypr_rad_es_nb.time,out.ypr_rad_es_nb.data(:,2),'b-');
plot(out.ypr_rad_es_nb.time,out.ypr_rad_es_nb.data(:,3),'g-');

subplot(2,2,2); 
hold on
title('EKFnb Linear Velocity')
axis on
grid on
xlabel('time [s]')
ylabel('[m/s]')
xlim([0 out.vel_lin_es_nb.Length/100])
plot(out.vel_lin_es_nb.time,out.vel_lin_es_nb.data(:,1),'g-');
plot(out.vel_lin_es_nb.time,out.vel_lin_es_nb.data(:,2),'b-');
plot(out.vel_lin_es_nb.time,out.vel_lin_es_nb.data(:,3),'r-');

subplot(2,2,3); 
hold on
title('EKFnb Angular Velocity')
axis on
grid on
xlabel('time [s]')
ylabel('[rad/s]')
xlim([0 out.ypr_rad_es.Length/100])
plot(out.vel_ang_es_nb.time,out.vel_ang_es_nb.data(:,3),'g-');
plot(out.vel_ang_es_nb.time,out.vel_ang_es_nb.data(:,2),'b-');
plot(out.vel_ang_es_nb.time,out.vel_ang_es_nb.data(:,1),'r-');

subplot(2,2,4); 
hold on
title('EKFnb Linear Acceleration ')
axis on
grid on
xlabel('time [s]')
ylabel('[m/s^2]')
xlim([0 out.ypr_rad_es.Length/100])
plot(out.acc_lin_es_nb.time,out.acc_lin_es_nb.data(:,1),'g-');
plot(out.acc_lin_es_nb.time,out.acc_lin_es_nb.data(:,2),'b-');
plot(out.acc_lin_es_nb.time,out.acc_lin_es_nb.data(:,3),'r-');

f.Position=[419 242 840 427];

fname = strcat( pwd,'\graphics' );
saveas(figure(11), fullfile(fname, 'EKFnb_all'), 'png')

