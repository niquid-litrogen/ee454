 function out_arr = threshold(in_arr, gamma)
%Convert input array to binary based pixel threshold parameter.
%inputs:
%    in_arr: MxN input array. It is assumed that all values are positive.
%    gamma: Positive scalar threshold. All values in "in_arr" < "gamma" are set to 0. All
%           values in "in_arr" >= gamma are set to 1.
%outputs:
%    out_arr: MxN binary array

out_arr = in_arr;
out_arr(out_arr < gamma) = 0;
%All remaining nonzero elements are >= threshold, and are set to 1.
out_arr(out_arr ~= 0) = 1;

end