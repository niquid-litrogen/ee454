function outarray = apply_fullconnect(inarray, filterbank, biasvals)
% Inputs: inarray is NxMxD1
%         filterbank is NxMxD1xD2,
%         biasvals is a length D2 vector,
%
% Output: outarray is 1x1xD2
%
% Applies D2 filters (similarly to a dot product) and adds biasvals to
% inarray to obtain D2 scalar values

%Get number of filters, which is also the number of output elements
D2 = size(filterbank,4);

outarray = zeros(1,1,D2);

for i = 1:1:D2
    %Get ith filter by indexing along last axis of filterbank
    filter = filterbank(:,:,:,i);
    %Get ith element of output vector. This operation is equivalent to flattening both 'filter' and
    %'inarray' into 1D vectors, taking their dot product, and adding the current filter's bias value.
    outarray(:,:,i) = sum(filter .* inarray, 'all') + biasvals(i);
end

