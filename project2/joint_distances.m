function joint_dists = joint_distances(mocapJoints, vue2, vue4)
% Calculates distances between each pair of joints in each input frame. 
% Distances are stored in the 2D array "joint_dists", where each row is a
% single frame and each column is a joint. joint_dists(i,j) is the distance
% between recovered and original joint "j" in frame "i". 
%
% Inputs: 
%       mocapJoints: An Nx12x4 matrix of joint locations in world
%           coordinates for N frames.
%       vue2/vue4: Structures containing intrinsic and extrinsic camera 
%           parameters for two different cameras.
% Outputs: 
%       joint_dists: An Nx12 matrix containing the distances between
%           recovered joint points and the original joint locations.

num_frames = length(mocapJoints);

%use array of nans for frames without joint data
%one row for each frame, one column for each joint
%Alternatively consider using -1 to mark off invalid frames, because 
%distance can never be negative, and it may be more convenient than working
%with nans.
joint_dists = NaN(num_frames, 12);

for i = 1:num_frames
    points_3D = squeeze(mocapJoints(i,:,:));
    
    %only consider frames that have data for all 12 joints (meaning that
    %last column has confidence score of all ones)
    if (all(points_3D(:,4) == ones(12,1)))
        points_2D_vue2 = project3DTo2D(vue2, points_3D);
        points_2D_vue4 = project3DTo2D(vue4, points_3D);
        
        recovered_points_3D = reconstruct3DFrom2D(vue2,points_2D_vue2,vue4,points_2D_vue4);
        %rows of "diffs" are the differences between true and recovered joint
        %locations
        diffs = recovered_points_3D - points_3D(:, 1:3);
        %calculate 2-norm of each row of diffs. This gets a 12*1 vector
        %containing the euclidean distance between each pair of true/recovered joint 
        %locations in the current frame. 
        dists = vecnorm(diffs,2,2);
        %store joint distance calculations in row of joint_dists that
        %corresponds to current frame
        joint_dists(i,:) = dists;
   end

end

end
