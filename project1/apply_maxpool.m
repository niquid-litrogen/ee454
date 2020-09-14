function outarray = apply_maxpool(inarray)
%inarray is size 2Nx2MxD of floats. 2N and 2M are assumed to be even numbers 
%outarray is size NxMxD of floats

N = int16(size(inarray,1)/2);
M = int16(size(inarray,2)/2);
D = size(inarray,3);

outarray = zeros(N,M,D);

for i=1:1:M
    for j=1:1:N
        for k=1:1:D
            %get max of 2x2 pixel block starting at index (2*i-1,2*j-1) in
            %kth channel of inarray. The '[]' in input arguments
            %is necessary for 'max' function to take max over entire 2x2
            %block.
            outarray(i,j,k) = max(inarray(2*i-1:2*i,2*j-1:2*j,k),[],'all');
        end
    end
end

