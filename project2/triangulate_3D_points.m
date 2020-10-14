function points_3D_recovered = triangulate_3D_points(cam1,cam2,cam1_points_2D,cam2_points_2D)
%Triangulate 3D point location, in world coordinates, given projected coordinates and camera parameters for two
%separate views. 
%inputs:
%    cam1,cam2: structure containing camera parameters
%    cam1_points_2D,cam2_points_2D: 2D arrays containing homogenous 2D projection coordinates of each point. These each have shape (3, num samples).
%                                   cam1_points_2D contains points in the film plane of cam1, and cam2_points_2D contains points in the film plane of cam2.
%outputs:
%    points_3D: 2D array of shape (num samples, 4), containing homogenous
%               coordinates for 3D points in world coordinates. Coordinates are given
%               across rows, instead of columns, for consistency of shape with input 3D data. 

num_points = size(cam1_points_2D,2);

[cam1_loc,cam1_view_directions] = get_viewing_rays(cam1,cam1_points_2D);
[cam2_loc,cam2_view_directions] = get_viewing_rays(cam2,cam2_points_2D);

intersections = get_pseudo_intersections(cam1_loc,cam1_view_directions,cam2_loc,cam2_view_directions);

%take transpose of intersections to make returned shape consistent with
%groundtruth 3D points. Add a column of ones to return homogeneous
%coordinates. 
points_3D_recovered = [intersections', ones(num_points,1)];

end

