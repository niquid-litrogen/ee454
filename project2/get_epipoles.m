function [E] = get_epipoles(cam1, cam2)
%Find and plot epipolar lines for vue2 and vue4

load('data_files\Vue2CalibInfo.mat'); %contains 'vue2' structure
load('data_files\Vue4CalibInfo.mat'); %contains 'vue4' structure

%for cam2 translated to -> cam1, cam2 matrix inverted/transposed:
R = cam1.Rmat*transpose(cam2.Rmat);
%location of cam2
loc = cam1.Pmat*[cam2.position(1); cam2.position(2); cam2.position(3); 1];
Tx = loc(1);
Ty = loc(2);
Tz = loc(3);
S = [0 -Tz Ty; Tz 0 -Tx; -Ty Tx 0];
E = R*S;

