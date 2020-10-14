%This debug script tests the accuracy of calculated viewing rays by
%checking if they are parallel to the true viewing rays. To determine
%"paralellness", the dot product between estimated and true viewing ray is
%calculated. The score can range between -1 and 1. A score of -1 means that
%the rays are antiparallel, and a score of 1 means that the rays are
%parallel. 

mocapFnum = 20000; %It is assumed that this frame contains data for all 12 joints

%Load data

%3D point data
load('data_files\Subject4-Session3-Take4_mocapJoints.mat');
%camera models
load('data_files\Vue2CalibInfo.mat'); %contains 'vue2' structure
load('data_files\Vue4CalibInfo.mat'); %contains 'vue4' structure

%Extract 3D point data for test frame. "squeeze" removes the outer
%dimension of size 1, leaving a 2D array.
points_3D = squeeze(mocapJoints(mocapFnum,:,:));

vue2_loc = (vue2.position)';
vue4_loc = (vue4.position)';

vue2_2D = forward_project(points_3D,vue2);
vue4_2D = forward_project(points_3D,vue4);

[~,vue2_dir] = get_viewing_rays(vue2,vue2_2D);
[~,vue4_dir] = get_viewing_rays(vue4,vue4_2D);

estimated_vue_dir = [vue2_dir,vue4_dir];

true_vue2_dir = points_3D(:,1:3)' - vue2_loc;
true_vue2_dir = normalize(true_vue2_dir,1,'norm');
true_vue4_dir = points_3D(:,1:3)' - vue4_loc;
true_vue4_dir = normalize(true_vue4_dir,1,'norm');

true_vue_dir = [true_vue2_dir,true_vue4_dir];

%compute dot products between corresponding estimated and groundtruth
%viewing ray directions
sim_scores = dot(estimated_vue_dir, true_vue_dir, 1); %use dim=1 to get dot products between columns

%ranges between (-1 and 1). A score of 1 means that the calculated viewing
%ray directions the same as the true viewing ray directions. A score of -1
%means that the calculated viewing ray directions are opposite of the true
%viewing ray directions.
avg_sim = mean(sim_scores)