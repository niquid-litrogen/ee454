function recovered3DPoints = reconstruct3DFrom2D(cam1, cam1PixelCoords,  cam2, cam2PixelCoords)
% Triangulate 3D point location, in world coordinates, given projected coordinates and camera parameters for two
% separate views. 
%
% Inputs:
%    cam1,cam2: structure containing camera parameters
%    cam1_PixelCoords, cam2_PixelCoords: 2D arrays containing homogenous 2D projection coordinates of each point. These each have shape (3, num samples).
%                                        cam1_points_2D contains points in the film plane of cam1, and cam2_points_2D contains points in the film plane of cam2.
% Outputs:
%    recovered3DPoints: 2D array of shape (3, num samples), containing
%                       coordinates for 3D points in world coordinates. Coordinates are given
%                       across columns. 

%Get viewing rays, parameterized by camera location and ray directions.
%View directions are 3D unit vectors.
[cam1_loc,cam1_view_directions] = get_viewing_rays(cam1,cam1PixelCoords);
[cam2_loc,cam2_view_directions] = get_viewing_rays(cam2,cam2PixelCoords);

%Triangulate the two viewing rays. This has shape (3, num samples). 
recovered3DPoints = get_pseudo_intersections(cam1_loc,cam1_view_directions,cam2_loc,cam2_view_directions);

end

