%close
%%
figure (5)
hold on
title('Accelerometer Measurements ')
axis on
grid on
xlabel('time [s]')
ylabel('[m/s^2]')
acc_x = plot(out.acc_IMU.time,out.acc_IMU.data(:,1),'green-');
acc_y = plot(out.acc_IMU.time,out.acc_IMU.data(:,2),'blue-');
acc_z = plot(out.acc_IMU.time,out.acc_IMU.data(:,3),'red-');
legend([acc_x acc_y acc_z],'ya_x','ya_y','ya_z')

fname = strcat( pwd,'\graphics' );
saveas(figure(5), fullfile(fname, 'IMU_acc'), 'png')
%%

figure (6)
hold on
title('Gyroscope Measurements ')
axis on
grid on
xlabel('time [s]')
ylabel('[rad/s]')
gyro_x = plot(out.gyro_IMU.time,out.gyro_IMU.data(:,3),'green-');
gyro_y = plot(out.gyro_IMU.time,out.gyro_IMU.data(:,2),'blue-');
gyro_z = plot(out.gyro_IMU.time,out.gyro_IMU.data(:,1),'red-');
legend([gyro_x gyro_y gyro_z],'yg_x','yg_y','yg_z')

fname = strcat( pwd,'\graphics' );
saveas(figure(6), fullfile(fname, 'IMU_gyro'), 'png')
