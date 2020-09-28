function outmatrix = guessmatrix(guessnum, probability, reality)
% A function that creates a confusion matrix for a given probability
% ranking. So if looking for the probability that the CNN correctly
% classifies the object with the 3rd highest probability, the "guessnum"
% would be 3. 
%
% Input: guessnum is integer from 1-10; probability is 10x10000 double; reality is 1x10000 double 
%
% Output: Outmatrix is a 10x10 double with CNN classifications corresponding to columns and
% true image classes corresponding to rows.
outmatrix = zeros(10, 10);
for i=1:length(reality)
    [~, I] = sort(probability(i,:), 'descend');
    row = reality(i);
    col = I(guessnum);
    outmatrix(row, col) = outmatrix(row, col) + 1;
end

end