%close
% tt1 = [1:100:14700];
% tt2 = [16300:100:length(out.GT_pos.data(:,1))];
f_GPS = 10;
tt_GPS = horzcat([1:t1_start*f_GPS],...
                    [t1_end*f_GPS:t2_start*f_GPS],...
                    [t2_end*f_GPS:t3_start*f_GPS],...
                    [t3_end*f_GPS:t4_start*f_GPS],...
                    [t4_end*f_GPS:694*f_GPS]);
strGPS = 'GPS';

p_xmin = min(vertcat(out.GT_pos.data(:,2),out.pos_es_nb.data(:,2),out.pos_es.data(:,2)));
p_xmax = max(vertcat(out.GT_pos.data(:,2),out.pos_es_nb.data(:,2),out.pos_es.data(:,2)));

p_ymin = min(vertcat(out.GT_pos.data(:,1),out.pos_es_nb.data(:,1),out.pos_es.data(:,1)));
p_ymax = max(vertcat(out.GT_pos.data(:,1),out.pos_es_nb.data(:,1),out.pos_es.data(:,1)));
%%

f=figure (12)
hold on
title(['EKF (no-bias) Trajectory 2D with ', strGPS ])
axis on
grid on
xlabel('yEast [m]')
ylabel('xNorth [m]')
axis([p_xmin-5 p_xmax+5 p_ymin-5 p_ymax+5])
GPS_data = plot(out.GPS_NED.data(tt_GPS,2),out.GPS_NED.data(tt_GPS,1),'yellow*');
real_tr = plot(out.GT_pos.data(:,2),out.GT_pos.data(:,1),'black-');
EKF_tr  = plot(out.pos_es_nb.data(:,2),out.pos_es_nb.data(:,1),'red.');
legend([GPS_data real_tr EKF_tr],strGPS,'Real trajectory','EKF-nb')

fname = strcat( pwd,'\graphics' );
saveas(figure(12), fullfile(fname, '2D_EKF_nb' ), 'png')
%f.Position=[1466 160 560 420];


%%
f=figure (13)
hold on
title(['EKF (with bias) Trajectory 2D with ', strGPS ])
axis on
grid on
xlabel('yEast [m]')
ylabel('xNorth [m]')
axis([p_xmin-5 p_xmax+5 p_ymin-5 p_ymax+5])
GPS_data = plot(out.GPS_NED.data(tt_GPS,2),out.GPS_NED.data(tt_GPS,1),'yellow*'); 
real_tr = plot(out.GT_pos.data(:,2),out.GT_pos.data(:,1),'black-');
EKF_tr  = plot(out.pos_es.data(:,2),out.pos_es.data(:,1),'blue.');
legend([GPS_data real_tr EKF_tr],strGPS,'Real trajectory','EKF')

fname = strcat( pwd,'\graphics' );
saveas(figure(13), fullfile(fname, '2D_EKF' ), 'png')
%f.Position=[2626 176 560 420];

%%
f=figure (14)
hold on
title(['EKFs Trajectory 2D with GPS'])
axis on
grid on
xlabel('yEast [m]')
ylabel('xNorth [m]')
axis([p_xmin-5 p_xmax+5 p_ymin-5 p_ymax+5])
GPS_data = plot(out.GPS_NED.data(tt_GPS,2),out.GPS_NED.data(tt_GPS,1),'yellow*'); 
real_tr = plot(out.GT_pos.data(:,2),out.GT_pos.data(:,1),'black-');
EKF_tr_nb  = plot(out.pos_es_nb.data(:,2),out.pos_es_nb.data(:,1),'red.');
EKF_tr  = plot(out.pos_es.data(:,2),out.pos_es.data(:,1),'blue.');
legend([GPS_data real_tr EKF_tr_nb EKF_tr],strGPS,'Real trajectory','EKF-nb','EKF')

fname = strcat( pwd,'\graphics' );
saveas(figure(14), fullfile(fname, '2D_EKF_compare' ), 'png')
%f.Position=[2047 515 560 420];

%% Sezione per il calcolo della norma dell'errore e confronto con indice RMSE

pos_err =    [out.pos_es.data(:,1)   - out.GT_pos.data(:,1),...
              out.pos_es.data(:,2)   - out.GT_pos.data(:,2),...
              out.pos_es.data(:,3)   - out.GT_pos.data(:,3)];
pos_err_nb = [out.pos_es_nb.data(:,1)- out.GT_pos.data(:,1),...
              out.pos_es_nb.data(:,2)- out.GT_pos.data(:,2),...
              out.pos_es_nb.data(:,3)- out.GT_pos.data(:,3)];
          
% for k = 14700:16300
%     pos_err(k,:)=pos_err(k-1,:);
%     pos_err_nb(k,:)=pos_err_nb(k-1,:);
% end     

%%
f=figure (15)
subplot(3,1,1);
hold on
title('xNorth Position Error')
axis on
grid on
xlabel('time [s/50]')
ylabel('xNorth err[m]')
xlim([0 out.pos_es.Length])
xNorth = plot(pos_err(:,1),'r-');
xNorthnb = plot(pos_err_nb(:,1),'g-');
legend('EKF','EKFnb')



subplot(3,1,2); 
hold on
title('yEast Position Error')
axis on
grid on
xlabel('time [s/50]')
ylabel('yEast err[m]')
xlim([0 out.pos_es.Length])
yEast = plot(pos_err(:,2),'r-');
yEastnb = plot(pos_err_nb(:,2),'g-');

subplot(3,1,3); 
hold on
title('zDown Position Error')
axis on
grid on
xlabel('time [s/50]')
ylabel('zDown err[m]')
xlim([0 out.pos_es.Length])
zDown = plot(pos_err(:,3),'r-');
zDownnb = plot(pos_err_nb(:,3),'g-');
f.Position=[215 59 1015 606];

fname = strcat( pwd,'\graphics' );
saveas(figure(15), fullfile(fname, 'pos_err'), 'png')

pos_err_norm    = zeros(1,length(pos_err));
pos_err_nb_norm = zeros(1,length(pos_err_nb));

for k=1:length(pos_err)
    pos_err_norm(k) = norm(pos_err(k,:));
    pos_err_nb_norm(k) = norm(pos_err_nb(k,:));
end

figure (16)
hold on
title(['Position Error Norm'])
axis on
grid on
xlabel('Time [s/50]')
xlim([0 out.SimulationMetadata.ModelInfo.StopTime*50])
ylabel('Absolute Error norm [m]')
% ylim([min([error_norm_GPS,error_norm_GPS])-0.5 max([error_norm_GPS,error_norm_GPS])+0.5])
plot(pos_err_norm,'r-','MarkerSize',2);
plot(pos_err_nb_norm,'g-','MarkerSize',2);
legend('EKF Error','EKFnb Error')

fname = strcat( pwd,'\graphics' );
saveas(figure(16), fullfile(fname, ['pos_error_norm']), 'png')

for k = 1:1000
    if isnan(pos_err(k,1))
        pos_err(k,1)=0;
    end
    if isnan(pos_err(k,2))
        pos_err(k,2)=0;
    end
    if isnan(pos_err(k,3))
        pos_err(k,3)=0;
    end
    if isnan(pos_err_nb(k,1))
        pos_err_nb(k,1)=0;
    end
    if isnan(pos_err_nb(k,2))
        pos_err_nb(k,2)=0;
    end
    if isnan(pos_err_nb(k,3))
        pos_err_nb(k,3)=0;
    end
end   

RMSE_EKF_x = sqrt(mean((pos_err(:,1)).^2));
RMSE_EKF_y = sqrt(mean((pos_err(:,2)).^2));
RMSE_EKF_z = sqrt(mean((pos_err(:,3)).^2));
RMSE_EKF = norm([RMSE_EKF_x RMSE_EKF_y RMSE_EKF_z]);

RMSE_EKFnb_x = sqrt(mean((pos_err_nb(:,1)).^2));
RMSE_EKFnb_y = sqrt(mean((pos_err_nb(:,2)).^2));
RMSE_EKFnb_z = sqrt(mean((pos_err_nb(:,3)).^2));
RMSE_EKFnb = norm([RMSE_EKFnb_x RMSE_EKFnb_y RMSE_EKFnb_z]);

VarNames = {'RMSEx', 'RMSEy', 'RMSEz','RMSE total'};
RowNames = {'EKF','EKFnb'};
T = table([RMSE_EKF_x;RMSE_EKFnb_x],[RMSE_EKF_y;RMSE_EKFnb_y],[RMSE_EKF_z;RMSE_EKFnb_z],[RMSE_EKF;RMSE_EKFnb], ...
    'VariableNames',VarNames,'RowNames',RowNames)
%writetable(T, ['RMSE_',strGPS,'.txt'] )
