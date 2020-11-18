%Demonstrates that project3 works with a demonstration of the "walk"
%frames.
clc; clear; close all;
dirstring = 'DataSets/AShipDeck';
maxframenum = 368;
abs_diff_threshold = 30;
alpha_parameter = 0.75;
gamma_parameter = 25;
proj3main(dirstring, maxframenum, abs_diff_threshold, alpha_parameter, gamma_parameter)
generate_video(maxframenum, 'output_images');
