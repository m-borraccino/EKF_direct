%close
%%
f=figure (7)
hold on
title(['SHOE Detector* with N=',num2str(SHOE_buffer_N)])
axis on
grid on
xlim([0 257])
ylim([0 max(out.SHOE_ris.data)]) 
xlabel('time [s]')
ylabel('SHOE Detector*')
SHOE_ris   = plot(out.SHOE_ris.time,out.SHOE_ris.data,'red-');
SHOE_gamma = yline(SHOE_threshold,'blue');
legend([SHOE_ris SHOE_gamma ],'ris','\gamma')
f.Position = [46 214 1278 354];
fname = strcat( pwd,'\graphics' );
saveas(figure(7), fullfile(fname, ['SHOE_N',num2str(SHOE_buffer_N)]), 'png')

%%
% figure (8)
% hold on
% title(['SHOE Detector* at different N'])
% axis on
% grid on
% xlim([0 257])
% ylim([0 max(out.SHOE_ris.data)]) 
% xlabel('time [s]')
% ylabel('SHOE Detector*')
% %SHOE_ris1   = plot(out.SHOE_ris.time,out.SHOE_ris.data,'red-');
% %SHOE_ris2   = plot(out.SHOE_ris.time,out.SHOE_ris.data,'green-');
% SHOE_ris3   = plot(out.SHOE_ris.time,out.SHOE_ris.data,'blue-');
% SHOE_gamma = yline(SHOE_threshold,'black');
% 
% legend([SHOE_ris1 SHOE_ris2 SHOE_ris3 SHOE_gamma ],'N=10','N=100','N=1000','\gamma')
% 
% fname = strcat( pwd,'\graphics' );
% saveas(figure(8), fullfile(fname, ['SHOE_N_all']), 'png')
