function outarray = apply_convolve(inarray,filterbank,biasvals)
%inarray is float NxMxD1
%filterbank is float RxCxD1xD2
%biasvals is a float vector of length D2
%outarray is float NxMxD2
N = size(inarray,1);
M = size(inarray,2);
D1 = size(inarray,3);
D2 = size(filterbank,4); %number of channels in outarray

outarray = zeros(N,M,D2);

for i = 1:1:D2
    %get ith filter and bias
    filter = filterbank(:,:,:,i);
    bias = biasvals(i);
    
    %filterout is the ith channel of outarray
    filterout = zeros(N,M);
    
    %apply convolution between jth channel of image and jth channel filter,
    %then add the results to the total output for channel "i" in outarray
    for j = 1:1:D1
        %zero padding is used as default border handling
        filterout = filterout + imfilter(inarray(:,:,j),filter(:,:,j),'same','conv');
    end
    
    filterout = filterout + bias;
    outarray(:,:,i) = filterout;
end