% --------------------     calcolo_matrice_H.m       -------------------- %
%{
% This file contains the symbolic calculation of matrix H use in the 
% correction step. At first the complete prediction model measurement is 
% written with symbolic variables, and then calculate the matrices with 
% jacobian function

% H = [9x22] Jacobian of prediction model measurement with respect to state x

% State vector x = [q w xg r v a xa]' [22x1]:
% q  = [q1 q2 q3 q4]    unit quaternion representing the attitude (1 2 3 4)
% w  = [wx wy wz]        angular velocity (5 6 7)
% xg = [xg_x xg_y xg_z]  gyro bias (8 9 10)
% r  = [rx ry rz]        position (NED)(11 12 13)
% v  = [vx vy vz]        linear velocity (NED) (14 15 16)
% a  = [ax ay az]        linear acceleration (NED) (17 18 19)
% xa = [xa_x xa_y xa_z]  accelerometer bias (20 21 22)

% Prediction model measurements  
% hv = Rnb'*v;
% hg = Rnb'*[0 0 -g]';
% hr = [rx ry rz];
% htheta = atan2(2*(q2*q3-q1*q4), 1-2*(q3^2+q4^2));
%}
%%
clc;

syms q1 q2 q3 q4 ...        
     wx wy wz ...
     xg_x xg_y xg_z ...
     rx ry rz ...
     vx vy vz ...
     ax ay az ...
     xa_x xa_y xa_z...
     g real

x = [q1 q2 q3 q4 wx wy wz xg_x xg_y xg_z rx ry rz vx vy vz ax ay az xa_x xa_y xa_z];

%Body-to-navigation rotation matrix
Rnb = [q1^2+q2^2-q3^2-q4^2,  2*(q2*q3-q1*q4),      2*(q1*q3+q2*q4); ...
          2*(q2*q3+q1*q4),  q1^2-q2^2+q3^2-q4^2,   2*(q3*q4-q1*q2); ...
          2*(q2*q4-q1*q3),   2*(q1*q2+q3*q4),    q1^2-q2^2-q3^2+q4^2];

%Dynamical Constraints Update
v = [vx vy vz]';        %velocity vector in navigation frame (vector state)
hv = Rnb'*v;            %velocity vector in body frame

hvy = hv(2);
hvz = hv(3);

%Roll and Pitch Updates
hg = Rnb'*[0 0 -g]';    %gravity vector in body frame
hgx = hg(1);
hgy = hg(2);
hgz = hg(3);

%Position and Heading Updates
hr = [rx ry rz];
hrx = hr(1);
hry = hr(2);
hrz = hr(3);

htheta = atan2(2*(q2*q3-q1*q4), 1-2*(q3^2+q4^2));

%% Calcolo del Jacobiano H
H = jacobian([hvy; hvz; hgx; hgy; hgz; hrx; hry; hrz; htheta], x)
