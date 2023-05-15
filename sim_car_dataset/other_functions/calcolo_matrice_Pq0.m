% --------------------    calcolo_matrice_Pq0.m      -------------------- %
%{
% This file contains the symbolic calculation of matrix deltaq to calculate
% Pq0 for the initialization task. At first the complete equation is 
% written with symbolic variables, and then calculate the matrices with 
% jacobian function.
% For more details see [27] (R. Munguia and A. Grau, "A Practical Method 
% for Implementing an Attitude and Heading Reference System," International 
% Journal of Advanced Robotic Systems, vol. 11, 2014) for more details.

% deltaq = [4x3] jacobian of quaternion equation from initial estimated
%          Euler's angles, accelerometer measurement and initial interval
%          time.

% Estimated Attutide eul = [yaw,pitch,roll]

% R  =nav2body_matrix_from(yaw,pitch,roll)
% q* = quaternion_from(R)

% deltaq = jacobian(q,eul)

%P_ = eye(3)* acc_variance/(init_time*100);
%Pq0 = dq*P_*dq';

%}
%%
clc;

syms yaw pitch roll real

R_nav2body =(calcolo_R(yaw,pitch,roll))';
%%
q1 = (1+R_nav2body(1,1)+R_nav2body(2,2)+R_nav2body(3,3))^0.5;
q2 = (R_nav2body(3,2)-R_nav2body(2,3)/(4*q1));
q3 = (R_nav2body(1,3)-R_nav2body(3,1)/(4*q1));
q4 = (R_nav2body(2,1)-R_nav2body(1,2)/(4*q1));

q = vertcat(q1,q2,q3,q4);
eul = [roll pitch yaw];

deltaq = jacobian(q,eul)

%Body to Navigation Rotation Matrix from Euler's Angles
function R = calcolo_R(Yaw,Pitch,Roll)
    R_x = [ 1               0              0   ;
            0            cos(Roll)    sin(Roll);
            0           -sin(Roll)    cos(Roll)];
    R_y = [cos(Pitch)       0         -sin(Pitch);
              0             1              0     ;
           sin(Pitch)       0          cos(Pitch)];
    R_z = [ cos(Yaw)       sin(Yaw)         0;
           -sin(Yaw)       cos(Yaw)         0;
              0             0              1];
    R = (R_z'*R_y')*R_x';    
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%% Direct EKF for 6D Pose,  Marco Borraccino %%%%%%%%%%
     %%%%%%%%%   SGN Project, University of Pisa, 2021   %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%