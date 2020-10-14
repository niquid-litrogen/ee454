function intersections = get_pseudo_intersections(cam1_loc,view1_dirs,cam2_loc,view2_dirs)
%Calculate 3D point that minimizes sum of squared distances to input
%viewing rays.
%inputs:
%    cam1_loc,cam2_loc: row vectors of camera location coordinates. These are the starting positions of viewing rays.
%    view_1_dirs,view2_dirs: 2D arrays of shape (3,num samples). The columns of these arrays are unit vectors specifying viewing ray
%                            directions. The columns in view1_dirs contain directions for rays starting from cam1_loc, and the 
%                            columns of view2_dirs contain directions for rays starting from cam2_loc. Additionally, The vector at
%                            column i of view1_dirs points to the same point as the vector in column i of view2_dirs.
%outputs:
%    intersections: 2D array of shape (3,num samples). Each column contains the identified 3D intersection point between a set of input viewing
%                   rays. Because viewing rays do not exactly intersect, the intersections are chosen as points that minimize the sum of squared 
%                   distances to both viewing rays.

num_points = size(view1_dirs,2);

intersections = zeros(3,num_points);

%iterate through each set of viewing rays and identify intersections
for i = 1:1:num_points
    u1 = view1_dirs(:,i);
    u2 = view2_dirs(:,i);
    %direction of segment that is perpendicular to both viewing rays. This
    %segment contains the psuedo intersection.
    u3 = cross(u1,u2);
    u3 = normalize(u3,'norm');
    
    %Solve system of linear equations to get lengths of viewing rays and
    %perpendicular segment (this is the same as given in slide 18 in
    %lecture 15).
    A = [u1,-u2,u3];
    disp(A);
    %entry 1 contains length of view ray 1, entry 2 contains length of view
    %ray 2, and entry 3 contains length of perpendicular segment
    ray_lengths = A\(cam2_loc-cam1_loc)'; 
    
    %calculate endpoints of line segment that is perpendicular to both viewing rays
    ray1_nearest_pt = cam1_loc' + ray_lengths(1)*u1; %endpoint on viewing ray 1
    ray2_nearest_pt = cam2_loc' + ray_lengths(2)*u2; %endpoint on viewing ray 2
    %calculate midpoint of line segment that is perpendicular to both viewing rays
    pseudo_intersection = (ray1_nearest_pt + ray2_nearest_pt)/2;

    intersections(:,i) = pseudo_intersection; 
end

