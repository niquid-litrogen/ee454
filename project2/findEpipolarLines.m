function [EpipolarLines1, EpipolarLines2] = findEpipolarLines(worldCoord3DPoints, cam1, cam1PixelCoords, cam2, cam2PixelCoords)
% Given two cameras, along with sets of forward projected points, outputs 
% vectors [a b c]' that corresponsd to epipolar lines of the form:
% ax + by + c = 0
% Inputs:
%    worldCoord3DPoints: Set of M input 3D points (Mx4)
%    cam1: Struct containing parameters for camera 1.
%    cam1PixelCoords: Forward projected pixel coords for camera 1.
%    cam2: Struct containing parameters for camera w.
%    cam2PixelCoords: Forward projected pixel coords for camera 2.
% Outputs:
%    EpipolarLines1: 3xM vector of line equations for camera 1, where M is
%    number of input points.
%    EpipolarLines2: 3xM vector of line equations for camera 2, where M is
%    the number of input points.

%vector of shape (3,num_points) containing number of input points
[~, num_points] = size(cam1PixelCoords);


%camera 1 in world coords as shape (3x1) vector, which is necessary for
%projection function
cam1_coords = cam1.position';
%Get "left" epipole, the coordinates of cam1 in image plane of cam2
cam1_2_epipole = project3DTo2D(cam2,cam1_coords);

%camera 1 in world coords as shape (3x1) vector, which is necessary for
%projection function
cam2_coords = cam2.position';
%Get "right" epipole, the coordinates of cam2 in image plane of cam1
cam2_1_epipole = project3DTo2D(cam1,cam2_coords);


for i = 1:1:num_points
%Slope of epipolar line in cam1 image plane
slope_1 = (cam2_1_epipole(2) - cam1PixelCoords(2,i))/(cam2_1_epipole(1) - cam1PixelCoords(1,i));
%Slope of epipolar line in cam2 image plane
slope_2 = (cam1_2_epipole(2) - cam2PixelCoords(2,i))/(cam1_2_epipole(1) - cam2PixelCoords(1,i));

EpipolarLines1(:, i) = [slope_1; -1; cam2_1_epipole(2)-(slope_1*cam2_1_epipole(1))];
EpipolarLines2(:, i) = [slope_2; -1; cam1_2_epipole(2)-(slope_2*cam1_2_epipole(1))];
end

