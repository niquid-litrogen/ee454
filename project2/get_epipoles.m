function [E, F] = get_epipoles(left, right)
%Find and plot epipolar lines for vue2 and vue4

load('data_files\Vue2CalibInfo.mat'); %contains 'vue2' structure
load('data_files\Vue4CalibInfo.mat'); %contains 'vue4' structure

%for cam2 translated to -> cam1, cam2 matrix inverted/transposed:
R = left.Rmat*transpose(right.Rmat);
%location of cam2
loc = left.Pmat*[right.position(1); right.position(2); right.position(3); 1];
Tx = loc(1);
Ty = loc(2);
Tz = loc(3);
S = [0 -Tz Ty; Tz 0 -Tx; -Ty Tx 0];
E = R*S;
M_r = right.Kmat;
M_r(1,1) = M_r(1,1) / right.foclen;
M_r(2,2) = M_r(2,2) / right.foclen;
M_l = left.Kmat;
M_l(1,1) = M_l(1,1) / left.foclen;
M_l(2,2) = M_l(2,2) / left.foclen;
F = transpose(inv(M_r))*E*inv(M_l);

