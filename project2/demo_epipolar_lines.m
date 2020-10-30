%Demo to display epipolar lines through a set of points in two camera views

%Specify an input frame number
%Note that, in project description, we are allowed to ignore frames that do
%not have values of all 1 in the confidence score. When inputting your own frame number, this demo may not work 
%if you use a frame that does not contain data for all 12 joints. In a full demo, simply discard frames that do not have all joints.
mocapFnum = 9500; %It is assumed that this frame contains data for all 12 joints

%use this to specify a color map for epipolar lines. 
%This a 12*3 vector, where each row contains an RGB color specification.
%Each of the 12 epipolar lines are colored according to a row in cmap.
%useful reference: 
%    https://www.mathworks.com/matlabcentral/answers/63173-plotting-13-lines-with-different-colors
cmap = jet(12);

%load data

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

%Get 2D point data for vue2 and vue4

%Extract 3D point data for test frame. "squeeze" removes the outer
%dimension of size 1, leaving a 2D array.
points_3D = squeeze(mocapJoints(mocapFnum,:,:));
%joint coordinates in vue2 image
points_2D_left = forward_project(points_3D,vue2);
%joint coordinates in vue4 image
points_2D_right = forward_project(points_3D,vue4);


%vue4 location in homogenous world coordinates, which is necessary for
%2D projection function
vue4_homog = [vue4.position,1];
%Get "left" epipole, the coordinates of vue4 in image plane of vue2
left_epipole = forward_project(vue4_homog,vue2);

%vue2 location in homogenous world coordinates
vue2_homog = [vue2.position,1];
%Get "right" epipole, the coordinates of vue2 in image plane of vue4
right_epipole = forward_project(vue2_homog,vue4);

%Plot epipolar lines in vue2 image

subplot(1,2,1);

%Display vue2 image for input frame number
vue2video.CurrentTime = (mocapFnum-1)*(50/100)/vue2video.FrameRate; %(50/100) factor handles frame rate difference between 3D point data and mp4 data
vue2vid2Frame = readFrame(vue2video);
image(vue2vid2Frame);
hold on;

%iterate through each joint in vue2 projection, plot the joint, and plot
%the epipolar line through the joint.
for i = 1:1:12
    color = cmap(i,:);
    
    vue2_point = points_2D_left(:,i);
    %Display dot for current joint
    scatter(vue2_point(1),vue2_point(2),'filled','MarkerEdgeColor',color,'MarkerFaceColor',color);
    hold on
    
    %Plot epipolar line through current joint using equation of line
    %through two given points
    [vue2_epipolar_line_x, vue2_epipolar_line_y] = sample_epipolar_lines(vue2_point,left_epipole);
    plot(vue2_epipolar_line_x,vue2_epipolar_line_y,'LineWidth',2,'Color',color);
    hold on
end

title("Epipolar lines in vue2");
hold off;

%Plot epipolar lines in vue4 image

subplot(1,2,2);

%Display vue2 image for input frame number
vue4video.CurrentTime = (mocapFnum-1)*(50/100)/vue4video.FrameRate; %(50/100) factor handles frame rate difference between 3D point data and mp4 data
vue4vid2Frame = readFrame(vue4video);
image(vue4vid2Frame);
hold on;

%iterate through each joint in vue4 projection, plot the joint, and plot
%the epipolar line through the joint.
for i = 1:1:12
    color = cmap(i,:);
    
    vue4_point = points_2D_right(:,i);
    %Display dot for current joint
    scatter(vue4_point(1),vue4_point(2),'filled','MarkerEdgeColor',color,'MarkerFaceColor',color);
    hold on
    
    %Plot epipolar line through current joint using equation of line
    %through two given points
    [vue4_epipolar_line_x, vue4_epipolar_line_y] = sample_epipolar_lines(vue4_point,right_epipole);
    plot(vue4_epipolar_line_x,vue4_epipolar_line_y,'LineWidth',2,'Color',color);
    hold on
end

title("Epipolar lines in vue4");
hold off;