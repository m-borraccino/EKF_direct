% --------------------       cutter_matrix.m         -------------------- %
%{
% This file contains a example of how the scaling of vector 'e' and 
% matrices 'H' and 'R' is made, related to function 'virtual' in Simulink.

% Change the value of 'flag_updates_vector' to see more cases.
%}
%%
H = eye(9,22);
e = [1 2 3 4 5 6 7 8 9];
R=diag([1 2 3 4 5 6 7 8 9]);
flag_updates_vector = [1 1 0];
i=0;
if  flag_updates_vector(1) == 0
    H(1-i,:) = [];
    e(1-i) = [];
    R(1-i,:) = [];
    R(:,1-i) = [];
    i=i+1;
    H(2-i,:) = [];
    e(2-i) = [];
    R(2-i,:) = [];
    R(:,2-i) = [];
    i=i+1;
end
if  flag_updates_vector(2) == 0
    H(3-i,:) = [];
    e(3-i) = [];
    R(3-i,:) = [];
    R(:,3-i) = [];
    i=i+1;
    H(4-i,:) = [];
    e(4-i) = [];
    R(4-i,:) = [];
    R(:,4-i) = [];
    i=i+1;
    H(5-i,:) = [];
    e(5-i) = [];
    R(5-i,:) = [];
    R(:,5-i) = [];
    i=i+1;
end
if  flag_updates_vector(3) == 0
    H(6-i,:) = [];
    e(6-i) = [];
    R(6-i,:) = [];
    R(:,6-i) = [];
    i=i+1;
    H(7-i,:) = [];
    e(7-i) = [];
    R(7-i,:) = [];
    R(:,7-i) = [];
    i=i+1;
    H(8-i,:) = [];
    e(8-i) = [];
    R(8-i,:) = [];
    R(:,8-i) = [];
    i=i+1;
    H(9-i,:) = [];
    e(9-i) = [];
    R(9-i,:) = [];
    R(:,9-i) = [];
end
H=H
e=e
R=R

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%% Direct EKF for 6D Pose,  Marco Borraccino %%%%%%%%%%
     %%%%%%%%%   SGN Project, University of Pisa, 2021   %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
