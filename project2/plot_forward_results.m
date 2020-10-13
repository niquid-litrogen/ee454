%Demo to display projected points on an image plane, for two camera models.

%Specify an input frame number
%Note that, in project description, we are allowed to ignore frames that do
%not have values of all 1 in the confidence score. When inputting your own frame number, this demo may not work 
%if you use a frame that does not contain data for all 12 joints. In a full demo, simply discard frames that do not have all joints.
mocapFnum = 15000; %It is assumed that this frame contains data for all 12 joints2

%Load data

%camera vue2 mp4 data
filenamevue2mp4 = 'data_files\Subject4-Session3-24form-Full-Take4-Vue2.mp4';
vue2video = VideoReader(filenamevue2mp4);
%camera vue4 mp4 data
filenamevue4mp4 = 'data_files\Subject4-Session3-24form-Full-Take4-Vue4.mp4';
vue4video = VideoReader(filenamevue4mp4);
%3D point data
load('data_files\Subject4-Session3-Take4_mocapJoints.mat');
%camera models
load('data_files\Vue2CalibInfo.mat'); %contains 'vue2' structure
load('data_files\Vue4CalibInfo.mat'); %contains 'vue4' structure

%Extract 3D point data for test frame. "squeeze" removes the outer
%dimension of size 1, leaving a 2D array.
points_3D = squeeze(mocapJoints(mocapFnum,:,:));
%Index identifying which points to pass to projection function. These
%points have a confidence score of '1'.
%in_frame = points_3D(:,4) == 1;

subplot(1,2,1);

%Display vue2 RGB image, for input frame number

%(50/100) factor handles frame rate difference between 3D point data and mp4 data
vue2video.CurrentTime = (mocapFnum-1)*(50/100)/vue2video.FrameRate;
vue2vid2Frame = readFrame(vue2video);

image(vue2vid2Frame);
hold on

%Project and plot points on top of vue2 RGB image

%Shape is (num points, 3). The columns of points_2D contain homogeneous
%coordinates.
points_2D_vue2 = forward_project(points_3D,vue2);

%pass only (x,y) coordinates instead of homogeneous coordinates
[skel_x1,skel_y1] = make_skeleton_2D(points_2D_vue2(1:2,:));
plot(skel_x1,skel_y1,'-ro');
title('vue2 forward projection');

subplot(1,2,2);

%Display vue4 RGB image, for input frame number

%(50/100) factor handles frame rate difference between 3D point data and mp4 data
vue4video.CurrentTime = (mocapFnum-1)*(50/100)/vue4video.FrameRate;
vue4vid2Frame = readFrame(vue4video);

image(vue4vid2Frame);
hold on

%Project and plot points on top of vue4 RGB image

%Shape is (num points, 3). The columns of points_2D contain homogeneous
%coordinates.
points_2D_vue4 = forward_project(points_3D,vue4);

%pass only (x,y) coordinates instead of homogeneous coordinates
[skel_x2,skel_y2] = make_skeleton_2D(points_2D_vue4(1:2,:));
plot(skel_x2,skel_y2,'-ro');
title('vue4 forward projection');