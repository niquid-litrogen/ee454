function outarray = apply_relu(inarray)
%inarray is NxMxD array of floats
%outarray is NxMxD array of floats

%outarray sets negative elements of inarray to 0
outarray = inarray;
outarray(outarray < 0) = 0;

end

