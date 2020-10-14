function [cam_pos,view_directions] = get_viewing_rays(camera,points_2D)
%Calculate viewing rays through projected points in the image plane of a
%camera. Each viewing ray is parameterized by two outputs, the camera
%position (in world coordinates) and a unit vector specifying ray direction.
%inputs:
%    camera: structure containing camera parameters.
%    points_2D: 2D matrix of shape (3, num samples). Each column of this matrix
%               contains homogeneous coordinates for a 2D point in the
%               camera's image plane. The last row should contain all 1s.
%outputs:
%    cam_pos: Position of camera, in world coordinates. This is the start
%             point of each viewing ray.
%    view_directions: 2D matrix of shape (3, num samples). Each column of this matrix
%                     contains a unit vector pointing in the direction from cam_pos to 
%                     the corresponding point in points_2D.

%The camera's location in world coordinates is already stored in the given
%structure. These coordinates are the same as the coordinates obtained from
%calculating -(R')*T, where T is the last column of the camera's Pmat.
cam_pos = camera.position;

view_directions = (camera.Rmat)'*inv(camera.Kmat)*points_2D;
%Normalize the columns of view_directions that so that they 
%are all unit vectors
view_directions = normalize(view_directions,1,'norm');

end

