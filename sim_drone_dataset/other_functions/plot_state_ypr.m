%close
%%
f=figure (17)
hold on
title('Attitude:Euler Angles EKF')
axis on
grid on
xlabel('time [s]')
ylabel('Euler Angles [rad]')
xlim([0 out.ypr_rad_es.Length/50])
yaw_es = plot(out.ypr_rad_es.time,out.ypr_rad_es.data(:,1),'red-');
pitch_es = plot(out.ypr_rad_es.time,out.ypr_rad_es.data(:,2),'blue-');
roll_es = plot(out.ypr_rad_es.time,out.ypr_rad_es.data(:,3),'green-');
legend([yaw_es pitch_es roll_es],'yaw','pitch','roll')
f.Position = [216 269 1014 367]

fname = strcat( pwd,'\graphics' );
saveas(figure(17), fullfile(fname, 'ypr_EKF'), 'png')
%%
f=figure (18)
hold on
title('Attitude:Euler Angles EKFnb')
axis on
grid on
xlabel('time [s]')
ylabel('Euler Angles [rad]')
xlim([0 out.ypr_rad_es_nb.Length/50])
yaw_esnb = plot(out.ypr_rad_es_nb.time,out.ypr_rad_es_nb.data(:,1),'red-');
pitch_esnb = plot(out.ypr_rad_es_nb.time,out.ypr_rad_es_nb.data(:,2),'blue-');
roll_esnb = plot(out.ypr_rad_es_nb.time,out.ypr_rad_es_nb.data(:,3),'green-');
legend([yaw_esnb pitch_esnb roll_esnb],'yaw','pitch','roll')
f.Position = [216 269 1014 367]

fname = strcat( pwd,'\graphics' );
saveas(figure(18), fullfile(fname, 'ypr_EKFnb'), 'png')

%%

f=figure (19)
hold on
title('EKF yaw vs Real yaw ')
axis on
grid on
xlabel('time [s]')
ylabel('[rad]')
xlim([0 out.ypr_rad_es.Length/50])
yaw_es = plot(out.ypr_rad_es.time,out.ypr_rad_es.data(:,1),'r-');
yaw_esnb = plot(out.ypr_rad_es_nb.time,out.ypr_rad_es_nb.data(:,1),'g-');
yaw_true = plot(out.true_ypr.time,out.true_ypr.data(:,1),'black-');
legend([yaw_es yaw_esnb yaw_true],'EKF yaw','EKFnb yaw','real yaw')
f.Position = [216 269 1014 367]

fname = strcat( pwd,'\graphics' );
saveas(figure(19), fullfile(fname, 'ypr_EKF_true'), 'png')
%%

%% Sezione per il calcolo della norma dell'errore e confronto con indice RMSE

ypr_err =    [wrapToPi(out.ypr_rad_es.data(:,1)   - out.true_ypr.data(:,1)),...
              wrapToPi(out.ypr_rad_es.data(:,2)   - out.true_ypr.data(:,2)),...
              wrapToPi(out.ypr_rad_es.data(:,3)   - out.true_ypr.data(:,3))];
ypr_err_nb = [wrapToPi(out.ypr_rad_es_nb.data(:,1)- out.true_ypr.data(:,1)),...
              wrapToPi(out.ypr_rad_es_nb.data(:,2)- out.true_ypr.data(:,2)),...
              wrapToPi(out.ypr_rad_es_nb.data(:,3)- out.true_ypr.data(:,3))];
    

f=figure (20)
subplot(3,1,1);
hold on
title('Yaw EKF Absolute Error')
axis on
grid on
xlabel('time [s/50]')
ylabel('Yaw err[rad]')
xlim([0 out.ypr_rad_es.Length])
yaw_es = plot(ypr_err(:,1),'r-');
yaw_esnb = plot(ypr_err_nb(:,1),'g-');
legend('EKF','EKFnb')

subplot(3,1,2); 
hold on
title('Pitch EKF Absolute Error')
axis on
grid on
xlabel('time [s/50]')
ylabel('Pitch err [rad]')
xlim([0 out.ypr_rad_es.Length])
pitch_es = plot(ypr_err(:,2),'r-');
pitch_esnb = plot(ypr_err_nb(:,2),'g-');

subplot(3,1,3); 
hold on
title('Roll EKF Absolute Error')
axis on
grid on
xlabel('time [s/50]')
ylabel('Roll err [rad]')
xlim([0 out.ypr_rad_es.Length])
roll_es = plot(ypr_err(:,3),'r-');
roll_esnb = plot(ypr_err_nb(:,3),'g-');

f.Position=[215 59 1015 606];

fname = strcat( pwd,'\graphics' );
saveas(figure(20), fullfile(fname, 'ypr_EKF_err'), 'png')
          
ypr_err_norm    = zeros(1,length(ypr_err));
ypr_err_nb_norm = zeros(1,length(ypr_err_nb));

for k=1:length(ypr_err)
    ypr_err_norm(k) = norm(ypr_err(k,:));
    ypr_err_nb_norm(k) = norm(ypr_err_nb(k,:));
end

figure (21)
hold on
title(['Attitude Error Norm'])
axis on
grid on
xlabel('Time [s/50]')
xlim([0 out.SimulationMetadata.ModelInfo.StopTime*50])
ylabel('Absolute Error norm [rad]')
% ylim([min([error_norm_GPS,error_norm_GPS])-0.5 max([error_norm_GPS,error_norm_GPS])+0.5])
plot(ypr_err_norm,'r-','MarkerSize',2);
plot(ypr_err_nb_norm,'g-','MarkerSize',2);
legend('EKF Error','EKFnb Error')

fname = strcat( pwd,'\graphics' );
saveas(figure(21), fullfile(fname, ['ypr_error_norm']), 'png')

for k = 1:1000
    if isnan(ypr_err(k,1))
        ypr_err(k,1)=0;
    end
    if isnan(ypr_err(k,2))
        ypr_err(k,2)=0;
    end
    if isnan(ypr_err(k,3))
        ypr_err(k,3)=0;
    end
    if isnan(ypr_err_nb(k,1))
        ypr_err_nb(k,1)=0;
    end
    if isnan(ypr_err_nb(k,2))
        ypr_err_nb(k,2)=0;
    end
    if isnan(ypr_err_nb(k,3))
        ypr_err_nb(k,3)=0;
    end
end   

RMSE_EKF_y = sqrt(mean((ypr_err(:,1)).^2));
RMSE_EKF_p = sqrt(mean((ypr_err(:,2)).^2));
RMSE_EKF_r = sqrt(mean((ypr_err(:,3)).^2));
RMSE_EKF_ypr = norm([RMSE_EKF_y RMSE_EKF_p RMSE_EKF_r]);

RMSE_EKFnb_y = sqrt(mean((ypr_err_nb(:,1)).^2));
RMSE_EKFnb_p = sqrt(mean((ypr_err_nb(:,2)).^2));
RMSE_EKFnb_r = sqrt(mean((ypr_err_nb(:,3)).^2));
RMSE_EKFnb_ypr = norm([RMSE_EKFnb_y RMSE_EKFnb_p RMSE_EKFnb_r]);

VarNames = {'RMSE yaw', 'RMSE pitch', 'RMSE roll','RMSE total'};
RowNames = {'EKF','EKFnb'};
T = table([RMSE_EKF_y;RMSE_EKFnb_y],[RMSE_EKF_p;RMSE_EKFnb_p],[RMSE_EKF_r;RMSE_EKFnb_r],[RMSE_EKF_ypr;RMSE_EKFnb_ypr], ...
    'VariableNames',VarNames,'RowNames',RowNames)
%writetable(T, ['RMSE_',strGPS,'.txt'] )


