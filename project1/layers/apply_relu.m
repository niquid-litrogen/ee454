function outarray = apply_relu(inarray)
% Input: inarray is NxMxD array of floats
%
% Output: outarray is NxMxD array of floats
%
% Sets negative elements of inarray to 0 in outarray.

outarray = inarray;
outarray(outarray < 0) = 0;

end

