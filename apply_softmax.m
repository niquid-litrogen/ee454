function outarray = apply_softmax(inarray)
%inarray is float 1x1xD
%outarray is float 1x1xD

alpha = max(inarray);

num_vec = exp(inarray - alpha);
%denom is a normalization constant that makes all entries in output sum to 1
denom = sum(num_vec,'all') ;

outarray = num_vec ./ denom;

end