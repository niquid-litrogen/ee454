function [skel_x,skel_y] = make_skeleton_2D(joints_2D)
%This function creates x and y matrices that, when plotted, display 2D
%points connected as a skeleton. It is assumed that the order of in input
%joints_2D matches the order given in pages 2 and 3 of the project
%description. Make sure that "joints_2D" only has x and y coordinates, and
%not homogeneous coordinates.
%
%useful reference for plotting multiple line segments: 
%    https://www.mathworks.com/matlabcentral/answers/353653-how-to-draw-bunch-of-line-segments
%inputs:
%    joints_2D: numpy array of shape (2, 12). First row contains x
%               coordinates, and second row contains y coordinates. There
%               is a column for each joint, and the order of columns
%               matches the specification given on pgaes 2 and 3 of the
%               project description
%    outputs: 
%        skel_x, skel_y: Matrices that you can input to plot function to
%                        plot skeleton.
                            
skel_x = zeros(2,11);
skel_y = zeros(2,11);

%right shoulder to right elbow
skel_x(:,1) = [joints_2D(1,1),joints_2D(1,2)];
skel_y(:,1) = [joints_2D(2,1),joints_2D(2,2)];
%right elbow to right wrist
skel_x(:,2) = [joints_2D(1,2),joints_2D(1,3)];
skel_y(:,2) = [joints_2D(2,2),joints_2D(2,3)];
%left shoulder to left elbow
skel_x(:,3) = [joints_2D(1,4),joints_2D(1,5)];
skel_y(:,3) = [joints_2D(2,4),joints_2D(2,5)];
%left elbow to left wrist
skel_x(:,4) = [joints_2D(1,5),joints_2D(1,6)];
skel_y(:,4) = [joints_2D(2,5),joints_2D(2,6)];
%right hip to right knee
skel_x(:,5) = [joints_2D(1,7),joints_2D(1,8)];
skel_y(:,5) = [joints_2D(2,7),joints_2D(2,8)];
%right knee to right ankle
skel_x(:,6) = [joints_2D(1,8),joints_2D(1,9)];
skel_y(:,6) = [joints_2D(2,8),joints_2D(2,9)];
%left hip to left knee
skel_x(:,7) = [joints_2D(1,10),joints_2D(1,11)];
skel_y(:,7) = [joints_2D(2,10),joints_2D(2,11)];
%left knee to left ankle
skel_x(:,8) = [joints_2D(1,11),joints_2D(1,12)];
skel_y(:,8) = [joints_2D(2,11),joints_2D(2,12)];
%right hip to left hip
skel_x(:,9) = [joints_2D(1,7),joints_2D(1,10)];
skel_y(:,9) = [joints_2D(2,7),joints_2D(2,10)];
%right shoulder to left shoulder
skel_x(:,10) = [joints_2D(1,1),joints_2D(1,4)];
skel_y(:,10) = [joints_2D(2,4),joints_2D(2,4)];
%spine
hip_midpt_x = (joints_2D(1,10) + joints_2D(1,7))/2;
hip_midpt_y = (joints_2D(2,10) + joints_2D(2,7))/2;

shoulder_midpt_x = (joints_2D(1,1) + joints_2D(1,4))/2;
shoulder_midpt_y = (joints_2D(2,1) + joints_2D(2,4))/2;

skel_x(:,11) = [hip_midpt_x,shoulder_midpt_x];
skel_y(:,11) = [hip_midpt_y,shoulder_midpt_y];