%Demonstrates that project3 works with a demonstration of the "walk"
%frames.
clc; clear; close all;
dirstring = 'DataSets/DataSets/walk';
maxframenum = 283;
abs_diff_threshold = 25;
alpha_parameter = 0.5;
gamma_parameter = 20;
proj3main(dirstring, maxframenum, abs_diff_threshold, alpha_parameter, gamma_parameter)
generate_video(maxframenum, 'output_images');
