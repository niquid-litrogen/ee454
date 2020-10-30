function projected2DPoints = project3DTo2D(cam, worldCoord3DPoints)
% Performs forward projection given 3D points in world coordinates and
% camera parameters.
%
% Inputs:
%    worldCoord3DPoints: 2D array of shape (3, num samples), where each column represents a 3D point in world
%                        coordinates. The last column contains only 1s, meaning that
%                        only points with a high confidence are input.               
%    cam: Structure containing intrinsic and extrinsic camera
%         parameters.
% Outputs:
%    projected2DPoints: 2d array of shape (3, num samples). Each column contains
%                       homogeneous coordinates for a projected point, in image plane of input
%                       camera model.

%number of points is the number of columns in the input points array
num_points = size(worldCoord3DPoints,2);

%Add a row of ones to the end of WorldCoord3DPoints before performing this
%calculation. This represents the input points as homogeneous coordinates,
%and is neccesary for the matrix shapes to line up.
projected2DPoints = cam.Kmat*cam.Pmat*[worldCoord3DPoints;ones(1,num_points)];
%Divide by Z coordinates to get true perspective projection. This command
%performs an elementwise division between each row of points_2D and the last
%row of points_2D (the Z coordinates).
projected2DPoints = projected2DPoints ./ projected2DPoints(3,:);

end