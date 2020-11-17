 function out_arr = apply_relu(in_arr, gamma)
% Input: inarray is NxMxD array of floats
%
% Output: outarray is NxMxD array of floats
%
% Sets negative elements of inarray to 0 in outarray.

out_arr = in_arr;
out_arr(out_arr < gamma) = 0;
out_arr(out_arr ~= 0) = 1;

end