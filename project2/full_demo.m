load('data_files\Subject4-Session3-Take4_mocapJoints.mat');
load('data_files\Vue2CalibInfo.mat'); %contains 'vue2' structure
load('data_files\Vue4CalibInfo.mat'); %contains 'vue4' structure

main_routine(mocapJoints, vue2, vue4)