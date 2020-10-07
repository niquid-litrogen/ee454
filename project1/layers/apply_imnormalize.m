function outarray = apply_imnormalize(inarray)
% Input: inarray is an NxMx3 uint8 image
%
% Output: outarray is an NxMx3 uint8 image
%
% Normalizes all pixel values in inarray to be within range [-0.5,0.5]

outarray = (double(inarray) ./ 255) - 0.5;

end

