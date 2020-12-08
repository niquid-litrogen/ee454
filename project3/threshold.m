function arr = threshold(arr, gamma)
%Convert input array to binary based on pixel level threshold parameter.
%inputs:
%    arr: MxN input array. It is assumed that all values are positive.
%    gamma: Positive scalar threshold. All values in "in_arr" < "gamma" are set to 0. All
%           values in "in_arr" >= gamma are set to 1.
%outputs:
%    arr: MxN binary array

arr(arr < gamma) = 0;
%All remaining nonzero elements are >= threshold, and are set to 1.
arr(arr ~= 0) = 1;

end