% --------------------     calcolo_matrice_F.m       -------------------- %
%{
% This file contains the symbolic calculation of matrix Fx and Fu used in
% the prediction step. At first the complete prediction model is written
% with symbolic variables, and then calculate the matrices with jacobian
% function

% Fx = [22x22] jacobian of prediction model with respect of state x
% Fu = [12x22] jacobian of prediction model with respect of inputs u

% State vector x = [q w xg r v a xa]' [22x1]:
% q  = [q1 q2 q3 q4]    unit quaternion representing the attitude (1 2 3 4)
% w  = [wx wy wz]       angular velocity (5 6 7)
% xg = [xg_x xg_y xg_z] gyro bias (8 9 10)
% r  = [rx ry rz]       position (NED)(11 12 13)
% v  = [vx vy vz]       linear velocity (NED) (14 15 16)
% a  = [ax ay az]       linear acceleration (NED) (17 18 19)
% xa = [xa_x xa_y xa_z] accelerometer bias (20 21 22)
 
System inputs:
% [yg1 yg2 yg3]    = Gyroscope measurement
% [vxg1 vxg2 vxg3] = Uncertainty in gyroscope bias drift
% [ya1 ya2 ya3]    = Accelerometer Measurement
% [vxa1 vxa2 vxa3] = Uncertainty in accelerometer bias drift

% Prediction model functions:
% fq = q * q(w*DT)
% fw = (yg-xg);
% fxg = (1-lambda_xg*DT)*xg+vxg;
% fr = r + v*DT + a*DT*DT/2;
% fv = v + a*DT;
% fa = Rnb*(ya - xa) + [0;0;g];
% fxa = (1-lambda_xa*DT)*xa+vxa;

% P_k = Fx*P_k_1*Fx' + Fu*U*Fu'
 
% U = [gyro_variance(3x3),       0               0               0
%        0           bias_gyro_variance(3x3)     0               0
%        0                       0        acc_variance(3x3)      0
%        0                       0                  bias_acc_variance(3x3)]
%}
%%
clc;

syms q1 q2 q3 q4 ...        
     w_yaw w_pitch w_roll ...
     xg_x xg_y xg_z ...
     rx ry rz ...
     vx vy vz ...
     ax ay az ...
     xa_x xa_y xa_z...
     g ...
     yg1 yg2 yg3 ...
     vxg1 vxg2 vxg3 ...
     ya1 ya2 ya3 ...
     vxa1 vxa2 vxa3 ...     
     real
 
lambda_xg = 1e-3;
lambda_xa = 1e-4;
DT = 0.02;
 
x = [q1 q2 q3 q4 w_yaw w_pitch w_roll xg_x xg_y xg_z rx ry rz vx vy vz ax ay az xa_x xa_y xa_z];
u = [yg1 yg2 yg3 vxg1 vxg2 vxg3 ya1 ya2 ya3 vxa1 vxa2 vxa3];

q  = [q1;q2;q3;q4];
w  = [w_yaw;w_pitch;w_roll];
xg = [xg_x;xg_y;xg_z];
r  = [rx;ry;rz];
v  = [vx;vy;vz];
a  = [ax;ay;az];
xa = [xa_x;xa_y;xa_z];

yg  = [yg1;yg2;yg3];
vxg = [vxg1;vxg2;vxg3];
ya  = [ya1;ya2;ya3];
vxa = [vxa1;vxa2;vxa3];

Rnb = [q1^2+q2^2-q3^2-q4^2,  2*(q2*q3-q1*q4),      2*(q1*q3+q2*q4); ...
          2*(q2*q3+q1*q4),  q1^2-q2^2+q3^2-q4^2,   2*(q3*q4-q1*q2); ...
          2*(q2*q4-q1*q3),   2*(q1*q2+q3*q4),    q1^2-q2^2-q3^2+q4^2];
%%
fq = [q1;q1;q1;q1];
w_DT = w*DT;
q_w(1) = cos(w_DT(3)/2) * cos(w_DT(2)/2) * cos(w_DT(1)/2) + sin(w_DT(3)/2) * sin(w_DT(2)/2) * sin(w_DT(1)/2);
q_w(2) = sin(w_DT(3)/2) * cos(w_DT(2)/2) * cos(w_DT(1)/2) - cos(w_DT(3)/2) * sin(w_DT(2)/2) * sin(w_DT(1)/2);
q_w(3) = cos(w_DT(3)/2) * sin(w_DT(2)/2) * cos(w_DT(1)/2) + sin(w_DT(3)/2) * cos(w_DT(2)/2) * sin(w_DT(1)/2);
q_w(4) = cos(w_DT(3)/2) * cos(w_DT(2)/2) * sin(w_DT(1)/2) - sin(w_DT(3)/2) * sin(w_DT(2)/2) * cos(w_DT(1)/2);
q_norm = (q(1)^2+q(2)^2+q(3)^2+q(4)^2)^0.5;
fq(1) = (q_w(1)*q(1) - q_w(2)*q(2) - q_w(3)*q(3) - q_w(4)*q(4))/q_norm;
fq(2) = (q_w(1)*q(2) + q_w(2)*q(1) - q_w(3)*q(4) + q_w(4)*q(3))/q_norm;
fq(3) = (q_w(1)*q(3) + q_w(2)*q(4) + q_w(3)*q(1) - q_w(4)*q(2))/q_norm;
fq(4) = (q_w(1)*q(4) - q_w(2)*q(3) + q_w(3)*q(2) + q_w(4)*q(1))/q_norm;

fw = (yg-xg);

fxg = (1-lambda_xg*DT)*xg+vxg;

fr = r + v*DT + a*DT*DT/2;
       
fv = v + a*DT;

fa = Rnb*(ya - xa) + [0;0;g];

fxa = (1-lambda_xa*DT)*xa+vxa;

f = vertcat(fq,fw,fxg,fr,fv,fa,fxa)

%%
Fx = jacobian(f,x)
Fu = jacobian(f,u)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%% Direct EKF for 6D Pose,  Marco Borraccino %%%%%%%%%%
     %%%%%%%%%   SGN Project, University of Pisa, 2021   %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%