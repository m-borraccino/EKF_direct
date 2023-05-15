%close
tt1 = [1:100:14700];
tt2 = [16300:100:length(out.GT_pos.data(:,1))];
f_GPS = 10;
tt_GPS = horzcat([1:t1_start*f_GPS],...
                    [t1_end*f_GPS:t2_start*f_GPS],...
                    [t2_end*f_GPS:t3_start*f_GPS],...
                    [t3_end*f_GPS:t4_start*f_GPS],...
                    [t4_end*f_GPS:694*f_GPS]);

p_xmin = min(vertcat(out.GT_pos.data(:,2),out.pos_es_nb.data(:,2),out.pos_es.data(:,2)));
p_xmax = max(vertcat(out.GT_pos.data(:,2),out.pos_es_nb.data(:,2),out.pos_es.data(:,2)));

p_ymin = min(vertcat(out.GT_pos.data(:,1),out.pos_es_nb.data(:,1),out.pos_es.data(:,1)));
p_ymax = max(vertcat(out.GT_pos.data(:,1),out.pos_es_nb.data(:,1),out.pos_es.data(:,1)));

%%
f=figure (22)
hold on
title(['EKFs Trajectory 2D with Error Ellipse'])
axis on
grid on
xlabel('yEast [m]')
ylabel('xNorth [m]')
axis([p_xmin-5 p_xmax+5 p_ymin-5 p_ymax+5])
plot(out.GT_pos.data(tt1,2),out.GT_pos.data(tt1,1),'black-');
real_tr = plot(out.GT_pos.data(tt2,2),out.GT_pos.data(tt2,1),'black-');
EKF_tr_nb  = plot(out.pos_es_nb.data(:,2),out.pos_es_nb.data(:,1),'red.');
EKF_tr  = plot(out.pos_es.data(:,2),out.pos_es.data(:,1),'blue.');
%legend([ real_tr EKF_tr_nb EKF_tr],'Real trajectory','EKF-nb','EKF')

fname = strcat( pwd,'\graphics' );
axis equal
% saveas(figure(22), fullfile(fname, '2D_EKF_ellipse' ), 'png')


%% Ellissi di Covarianza

for i=1:10:length(out.pos_es.data)-1
    error_ellipse(out.pos_es.data(i,1), out.pos_es.data(i,2),out.P_es.data(11:12,11:12,i),0.95)
end

for i=1:10:length(out.pos_es.data)-1
    error_ellipse(out.pos_es_nb.data(i,1), out.pos_es_nb.data(i,2),out.P_es_nb.data(8:9,8:9,i),0.95)
end
%% Grafico varianza x e y della posizione

figure(23)
hold on
title(['Estimed Position Variance'])
axis on
grid on
xlabel('time [s/100]')
ylabel('Variance [m^2]')
for i=1:10:length(out.P_es.data)-1
    covx = plot(i,out.P_es.data(11,11,i),'blue.');
    covy = plot(i,out.P_es.data(12,12,i),'red.');
end
legend([covx covy],'\sigma_x^2','\sigma_y^2')

fname = strcat( pwd,'\graphics' );
saveas(figure(23), fullfile(fname, 'Covariance' ), 'png')