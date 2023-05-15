%close
tt1 = [1:100:14700];
tt2 = [16300:100:length(out.GT_pos.data(:,1))];
f_GPS = 10;
tt_GPS = [1:257*f_GPS];
tt_GPS = horzcat([1:t1_start*f_GPS],...
                    [t1_end*f_GPS:t2_start*f_GPS],...
                    [t2_end*f_GPS:t3_start*f_GPS],...
                    [t3_end*f_GPS:t4_start*f_GPS],...
                    [t4_end*f_GPS:694*f_GPS]);

strGPS = 'GPS';
%%

figure (1)
hold on
title(['Ground Truth & ', strGPS ])
axis on
grid on
xlabel('yEast [m]')
ylabel('xNorth [m]')
ylim([min(out.GPS_NED.data(:,1))-10 max(out.GT_pos.data(:,1)+5)])
GPS_data = plot(out.GPS_NED.data(tt_GPS,2),out.GPS_NED.data(tt_GPS,1),'yellow*');
real_tr = plot(out.GT_pos.data(:,2),out.GT_pos.data(:,1),'black-');
legend([GPS_data real_tr ],strGPS,'Real trajectory')

fname = strcat( pwd,'\graphics' );
saveas(figure(1), fullfile(fname, ['2D_GT_',strGPS]), 'png')

%%
% figure (2)
% hold on
% title(['Yaw & Heading ', strGPS ])
% axis on
% grid on
% xlabel('time [s]')
% ylabel('[rad]')
% yaw_true = plot(out.true_ypr.time,out.true_ypr.data(:,1),'black-');
% GPS_head = plot(out.heading_GPS.time,out.heading_GPS.data(:,1),'green-');
% legend([yaw_true GPS_head ],'True Yaw',[strGPS,' heading'])
% 
% fname = strcat( pwd,'\graphics' );
% saveas(figure(2), fullfile(fname, ['head_',strGPS]), 'png')


%% Sezione per il calcolo della norma dell'errore e confronto con indice RMSE

error_GPS = [out.GT_GPS_err.data(:,1),out.GT_GPS_err.data(:,2),out.GT_GPS_err.data(:,3)];
    
error_norm_GPS = zeros(1,length(error_GPS));

for k=1:length(error_GPS)
    error_norm_GPS(k) = norm(error_GPS(k,:));
end

figure (3)
hold on
title([strGPS,' Error Norm'])
axis on
grid on
xlabel('Time [s/50]')
% xlim([0 out.SimulationMetadata.ModelInfo.StopTime])
ylabel('Absolute Error norm [m]')
% ylim([min([error_norm_GPS,error_norm_GPS])-0.5 max([error_norm_GPS,error_norm_GPS])+0.5])
plot(error_norm_GPS,'r-','MarkerSize',2);
legend('GPS Error')
fname = strcat( pwd,'\graphics' );
saveas(figure(3), fullfile(fname, [strGPS,'_error_norm']), 'png')

figure (4)
hold on
title([strGPS,' Error'])
axis on
grid on
xlabel('Time [s/50]')
% xlim([0 out.SimulationMetadata.ModelInfo.StopTime])
ylabel([' Absolute Error [m]'])
% ylim([min([error_norm_GPS,error_norm_GPS])-0.5 max([error_norm_GPS,error_norm_GPS])+0.5])
plot(error_GPS(:,3),'g-','MarkerSize',2);
plot(error_GPS(:,2),'b-','MarkerSize',2);
plot(error_GPS(:,1),'r-','MarkerSize',2);
legend('GPS_z','GPS_y','GPS_x')
fname = strcat( pwd,'\graphics' );
saveas(figure(4), fullfile(fname, [strGPS,'_error']), 'png')

RMSE_GPS_x = sqrt(mean((error_GPS(:,1)).^2));
RMSE_GPS_y = sqrt(mean((error_GPS(:,2)).^2));
RMSE_GPS_z = sqrt(mean((error_GPS(:,3)).^2));

RMSE_GPS = norm([RMSE_GPS_x RMSE_GPS_y RMSE_GPS_z]);
VarNames = {'RMSEx', 'RMSEy', 'RMSEz','RMSE total'};
RowNames = {strGPS};
T = table([RMSE_GPS_x],[RMSE_GPS_y],[RMSE_GPS_z],[RMSE_GPS], ...
    'VariableNames',VarNames,'RowNames',RowNames)

%writetable(T, ['RMSE_',strGPS,'.txt'] )

