function outarray = apply_imnormalize(inarray)
%inarray is an NxMx3 uint8 image and outarray is NxMx3;
%Normalize all pixel values in inarray to be within range [-0.5,0.5]

outarray = (double(inarray) ./ 255) - 0.5;

end

