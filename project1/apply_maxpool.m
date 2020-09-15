function outarray = apply_maxpool(inarray)
% Input: inarray is size 2Nx2MxD of floats (2N and 2M are assumed to be even
%           numbers).
%
% Output: outarray is size NxMxD of floats
%
% Reduces the spatial size of inarray by producing an output having only
% half the number of rows and columns for the spatial dimensions. For each
% channel of inarray, assigns new values of outarray as max value per 2x2
% block.

N = int16(size(inarray,1)/2);
M = int16(size(inarray,2)/2);
D = size(inarray,3);

outarray = zeros(N,M,D);

for i=1:D
    pos1 = inarray(1:2:end, 1:2:end, i);
    pos2 = inarray(2:2:end, 1:2:end, i);
    pos3 = inarray(1:2:end, 2:2:end, i);
    pos4 = inarray(2:2:end, 2:2:end, i);
    outarray(:,:,i) = max(pos1, max(pos2, max(pos3, pos4)));
end
