function projected2DPoints = project3DTo2D(cam, worldCoord3DPoints)
% Performs forward projection given 3D points in world coordinates and
% camera parameters.
%
% Inputs:
%    points_3D: 2D array of shape (num samples, 4), where each row represents a 3D point in world
%               coordinates. The last column contains only 1s, meaning that
%               only points with a high confidence are input.               
%    cam_vue: Structure containing intrinsic and extrinsic camera
%             parameters.
% Outputs:
%    points_2D: 2d array of shape (3, num samples). Each column contains
%    homogeneous coordinates for a projected point, in image plane of input
%    camera model.

%Use transpose of points_3D so that shapes line up
projected2DPoints = cam.Kmat*cam.Pmat*worldCoord3DPoints';
%Divide by Z coordinates to get true perspective projection. This command
%performs an elementwise division between each row of points_2D and the last
%row of points_2D (the Z coordinates).
projected2DPoints = projected2DPoints ./ projected2DPoints(3,:);

end

