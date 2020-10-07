function points_2D = forward_project(points_3D,cam_vue)
%Perform forward projection given 3D points in world coordinates and
%camera parameters.
%inputs:
%    points_3D: 2D array of shape (num samples, 4), where each row represents a 3D point in world
%               coordinates. The last column contains only 1s, meaning that
%               only points with a high confidence are input.               
%    cam_vue: Structure containing intrinsic and extrinsic camera
%             parameters.
%outputs:
%    points_2D: 2d array of shape (3, num samples). Each column contains
%    homogeneous coordinates for a projected point, in image plane of input
%    camera model.

%Use transpose of points_3D so that shapes line up
points_2D = cam_vue.Kmat*cam_vue.Pmat*points_3D';
%Divide by Z coordinates to get true perspective projection. This command
%performs an elementwise division between each row of points_2D and the last
%row of points_2D (the Z coordinates).
points_2D = points_2D ./ points_2D(3,:);

end

