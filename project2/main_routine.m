function joint_dists = main_routine(joint_dataset, vue2, vue4)
% Applies forward projection to joint points, triangulates the projected
% point positions, calculates the distances between recovered points and
% the original points, and finally outputs metrics for the differences in
% distances for each joint.
%
% Inputs: 
%       joint_dataset: An Nx12x4 matrix of joint locations in world
%           coordinates for N frames.
%       vue2/vue4: Structures containing intrinsic and extrinsic camera 
%           parameters for two different cameras.
% Outputs: 
%       joint_dists: An Nx12 matrix containing the distances between
%           recovered joint points and the original joint locations. 
%       Also writes metrics for each joint to the file metrics_table.xlsx 
%           where the last row indicates metrics across all 12 joints.


joint_dists = joint_distances(joint_dataset, vue2, vue4);
metrics = generate_metrics(joint_dists);


metrics_titles = ["Mean" "Std Dev" "Min" "Median" "Max"];

filename = 'metrics_table.xlsx';
writematrix(metrics_titles, filename, 'Range', 'A1');
writematrix(metrics(1:end-1,:), filename, 'Range', 'A2');

writematrix('Combined ' + metrics_titles, filename, 'Range', 'A16')
writematrix(metrics(end,:), filename, 'Range', 'A17');

end