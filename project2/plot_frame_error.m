load 'joint_dist_info.mat';

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

plot(frame_num, frame_error);
title('Distance Error Per Frame');
xlabel('Frame Number');
ylabel('Sum of L^{2} Error');