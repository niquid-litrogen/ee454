function [EpipolarLines1, EpipolarLines2] = findEpipolarLines(worldCoord3DPoints, cam1, cam1PixelCoords, cam2, cam2PixelCoords)
% Given two points on an epipolar line, returns x and y coordinates that can
% be plotted.
%
% Inputs:
%    point_2D: 3x1 array, homogenous coordinates of a joint projected into a camera view.
%    epipole: 3x1 array, epipole location in homogenous camera coordinates.
% Outputs:
%    epipolar_line_x: array of x coordinates along epipolar line with input endpoints. 
%    epiolar_line_y: array of y coordinates along epipolar line with input
%                     endpoints.

%vector of shape (1,num_lines) containing slopes of epipolar lines)
[~, num_points] = size(worldCoord3dPoints)


%Homogenous world coordinates, which is necessary for
%2D projection function
cam1_homog = [cam1.position,1];
%Get "left" epipole, the coordinates of cam1 in image plane of cam2
cam1_2_epipole = forward_project(cam1_homog,cam2);

%Homogenous world coordinates
cam2_homog = [cam2.position,1];
%Get "right" epipole, the coordinates of cam2 in image plane of cam1
cam2_1_epipole = forward_project(cam2_homog,cam1);


for i = 1:1:num_points
%Slope of epipolar line in cam1 image plane
slope_1 = (cam2_1_epipole(2) - cam1PixelCoords(:,2))/(cam2_1_epipole(1) - cam1PixelCoords(:,1));
%Slope of epipolar line in cam2 image plane
slope_2 = (cam1_2_epipole(2) - cam2PixelCoords(:,2))/(cam1_2_epipole(1) - cam2PixelCoords(:,1));

EpipolarLines1(:, i) = [slope_1; -1; (cam1PixelCoords(2) - slope_1*cam1PixelCoords(1))];
EpipolarLines2(:, i) = [slope_2; -1; (cam2PixelCoords(2) - slope_2*cam2PixelCoords(1))];
end

