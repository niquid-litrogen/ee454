function metrics_matrix = generate_metrics(joint_dists)
% Creates an excel file with the distance metrics computed for
% our given input data. A 13x5 table is generated using the "joint_dists"
% input variable. The 5 generated metrics are the mean, standard deviation, 
% minimum, median and maximum values. The last row includes summary metrics
% across all 12 of the joints.
%
% Inputs: 
%       joint_dataset: An Nx12x4 matrix of joint locations in world
%       coordinates for N frames.
% Outputs: 
%       metrics_matrix: A 13x5 matrix of the mean, standard deviation, min,
%           median, and max metrics for the 12 joints. Additionally, the 
%           last row presents combined metrics across all 12 joints. 

data_size = size(joint_dists);
for i=1:data_size(2)
    mean_vals(i) = mean(joint_dists(:,i), 'omitnan');
    std_vals(i) = std(joint_dists(:,i), 'omitnan');
    min_vals(i) = min(joint_dists(:,i), [], 'omitnan');
    med_vals(i) = median(joint_dists(:,i), 'omitnan');
    max_vals(i) = max(joint_dists(:,i), [], 'omitnan');
end

end_row = 1 + data_size(2);

mean_vals(end_row) = mean(joint_dists(:), 'omitnan');
std_vals(end_row) = std(joint_dists(:), 'omitnan');
min_vals(end_row) = min(min_vals);
med_vals(end_row) = median(joint_dists(:), 'all', 'omitnan');
max_vals(end_row) = max(max_vals);

metrics_matrix(:, 1) = mean_vals;
metrics_matrix(:, 2) = std_vals;
metrics_matrix(:, 3) = min_vals;
metrics_matrix(:, 4) = med_vals;
metrics_matrix(:, 5) = max_vals;

end