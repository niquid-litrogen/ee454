%Demonstration of project 3 using selected video file and algorithm
%parameters. The demo output is written to a video, titled "testout.mp4".
clc; clear; close all;

%Demo Parameters

%Use "dirstring" to select the input video. This is assumed to be a
%directory of images, with the filename format f0001.jpg, f0002.jpg, ...
dirstring = 'DataSets/AShipDeck';

%Use "maxframenum" to specify the last input image to use. It is assumed
%that this does not exceed the number of frames in the input.
maxframenum = 368;

%Use "abs_diff_threshold" to specify the difference threhsold for motion
%detection. It is assumed that this number is between 0 and 255.
abs_diff_threshold = 30;

%Use "alpha_parameter" to control blending in adaptive background
%subtraction. It is assumed that this number is between 0 and 1. 
alpha_parameter = 0.1;

%Use "gamma_parameter" to cotrol how quickly detected motion fades away in
%persistent frame differencing. It is assumed that this number is between
%0 and 255.
gamma_parameter = 50;

%Run demo
%Run background subtraction experiment, and generate directory of output images.
proj3main(dirstring, maxframenum, abs_diff_threshold, alpha_parameter, gamma_parameter)
%Write output directory to mp4 video.
generate_video(maxframenum, 'output_images');
