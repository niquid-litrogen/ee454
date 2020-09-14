function outarray = apply_softmax(inarray)
% Input: inarray is float 1x1xD
%
% Output: outarray is float 1x1xD
%
% Scales the scalars from inarray to lie between 0 and 1.

alpha = max(inarray);

num_vec = exp(inarray - alpha);
%denom is a normalization constant that makes all entries in output sum to 1
denom = sum(num_vec,'all') ;

outarray = num_vec ./ denom;

end