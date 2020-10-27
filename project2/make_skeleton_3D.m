function [skel_x,skel_y,skel_z] = make_skeleton_3D(joints_3D)
% This function creates x, y, and z matrices that, when plotted, display 2D
% points connected as a skeleton. It is assumed that the order of points in input
% joints_3D matches the order given in pages 2 and 3 of the project
% description. Make sure that "joints_3D" may have x,y,z or homogeneous coordinates.
% 
% useful reference for plotting multiple line segments: 
%    https://www.mathworks.com/matlabcentral/answers/353653-how-to-draw-bunch-of-line-segments
% inputs:
%    joints_3D: numpy array of shape (12, 3). First column contains x
%               coordinates, second column contains y coordinates, and 
%               third column contains z coordinates. There
%               is a row for each joint, and the order of rows
%               matches the specification given on pages 2 and 3 of the
%               project description
% outputs: 
%    skel_x, skel_y, skel_z: Matrices that you can input to plot3 function to
%               plot skeleton.
                            
skel_x = zeros(2,11);
skel_y = zeros(2,11);
skel_z = zeros(2,11);

%right shoulder to right elbow
skel_x(:,1) = [joints_3D(1,1),joints_3D(2,1)];
skel_y(:,1) = [joints_3D(1,2),joints_3D(2,2)];
skel_z(:,1) = [joints_3D(1,3),joints_3D(2,3)];
%right elbow to right wrist
skel_x(:,2) = [joints_3D(2,1),joints_3D(3,1)];
skel_y(:,2) = [joints_3D(2,2),joints_3D(3,2)];
skel_z(:,2) = [joints_3D(2,3),joints_3D(3,3)];
%left shoulder to left elbow
skel_x(:,3) = [joints_3D(4,1),joints_3D(5,1)];
skel_y(:,3) = [joints_3D(4,2),joints_3D(5,2)];
skel_z(:,3) = [joints_3D(4,3),joints_3D(5,3)];
%left elbow to left wrist
skel_x(:,4) = [joints_3D(5,1),joints_3D(6,1)];
skel_y(:,4) = [joints_3D(5,2),joints_3D(6,2)];
skel_z(:,4) = [joints_3D(5,3),joints_3D(6,3)];
%right hip to right knee
skel_x(:,5) = [joints_3D(7,1),joints_3D(8,1)];
skel_y(:,5) = [joints_3D(7,2),joints_3D(8,2)];
skel_z(:,5) = [joints_3D(7,3),joints_3D(8,3)];
%right knee to right ankle
skel_x(:,6) = [joints_3D(8,1),joints_3D(9,1)];
skel_y(:,6) = [joints_3D(8,2),joints_3D(9,2)];
skel_z(:,6) = [joints_3D(8,3),joints_3D(9,3)];
%left hip to left knee
skel_x(:,7) = [joints_3D(10,1),joints_3D(11,1)];
skel_y(:,7) = [joints_3D(10,2),joints_3D(11,2)];
skel_z(:,7) = [joints_3D(10,3),joints_3D(11,3)];
%left knee to left ankle
skel_x(:,8) = [joints_3D(11,1),joints_3D(12,1)];
skel_y(:,8) = [joints_3D(11,2),joints_3D(12,2)];
skel_z(:,8) = [joints_3D(11,3),joints_3D(12,3)];
%right hip to left hip
skel_x(:,9) = [joints_3D(7,1),joints_3D(10,1)];
skel_y(:,9) = [joints_3D(7,2),joints_3D(10,2)];
skel_z(:,9) = [joints_3D(7,3),joints_3D(10,3)];
%right shoulder to left shoulder
skel_x(:,10) = [joints_3D(1,1),joints_3D(4,1)];
skel_y(:,10) = [joints_3D(1,2),joints_3D(4,2)];
skel_z(:,10) = [joints_3D(1,3),joints_3D(4,3)];
%spine
hip_midpt_x = (joints_3D(10,1) + joints_3D(7,1))/2;
hip_midpt_y = (joints_3D(10,2) + joints_3D(7,2))/2;
hip_midpt_z = (joints_3D(10,3) + joints_3D(7,3))/2;

shoulder_midpt_x = (joints_3D(1,1) + joints_3D(4,1))/2;
shoulder_midpt_y = (joints_3D(1,2) + joints_3D(4,2))/2;
shoulder_midpt_z = (joints_3D(1,3) + joints_3D(4,3))/2;

skel_x(:,11) = [hip_midpt_x,shoulder_midpt_x];
skel_y(:,11) = [hip_midpt_y,shoulder_midpt_y];
skel_z(:,11) = [hip_midpt_z,shoulder_midpt_z];