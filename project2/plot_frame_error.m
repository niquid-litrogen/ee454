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

data_size = size(joint_dists);

%preallocating arrays
frame_error = zeros(data_size(1),1);
frame_num = frame_error;
%iterate through each frame
for i=1:data_size(1)
    frame_num(i) = i;
    error_sum = sum(joint_dists(i,:));
    if(isnan(error_sum))
        frame_error(i) = 0; %assume 0 error for non confident frames
    else
        frame_error(i) = error_sum; 
    end
end
[min_err, min_err_index] = min(frame_error(frame_error>0));
[max_err, max_err_index] = max(frame_error);
disp(['Frame # with minimum error: ' num2str(min_err_index)])
disp(['Frame # with minimum error: ' num2str(max_err_index)])

plot(frame_num, frame_error);
title('Distance Error Per Frame');
xlabel('Frame Number');
ylabel('Sum of L^{2} Error');

save('minmax_errors.mat', 'min_err', 'min_err_index', 'max_err', 'max_err_index');
end