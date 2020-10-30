function plot_frame_error(joint_dists)
% For each frame, calculate the total error as distances between the
% recovered and original joint points. Also finds the frames with the 
% minimum and maximum error and plots the results per frame. 
%
% Inputs: 
%       joint_dists: An Nx12 matrix containing the distances between
%           recovered joint points and the original joint locations.
% Outputs: 
%       joint_dists: An Nx12 matrix containing the distances between
%           recovered joint points and the original joint locations.

%preallocating arrays
frame_error = zeros(size(joint_dists,1),1);
frame_num = (1:size(joint_dists,1))';
%iterate through each frame
for i=1:size(joint_dists,1)
    error_sum = sum(joint_dists(i,:));
    if(~isnan(error_sum))
        frame_error(i) = error_sum; %assume 0 error for non confident frames
    end
end
min_err = min(frame_error(frame_error>0));
min_err_index = find(frame_error == min_err);
[max_err, max_err_index] = max(frame_error);
disp(['Frame # with minimum error: ' num2str(min_err_index)])
disp(['Frame # with maximum error: ' num2str(max_err_index)])

plot(frame_num, frame_error);
title('Distance Error Per Frame');
xlabel('Frame Number');
ylabel('Sum of L^{2} Error');

save('minmax_errors.mat', 'min_err', 'min_err_index', 'max_err', 'max_err_index');
end