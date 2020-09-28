function accurate = guessaccuracy(guess_matrix)
%A function to evaluate the accuracy of a confusion matrix for a given
%"guess".
%Input: guess_matrix is 10x10 double
%
%Output: accurate is a 1x1 (scalar) double
success = 0;
total = 0; 
for i=1:size(guess_matrix, 1)
    for j=1:size(guess_matrix, 2)
        if(j == i)
            success = success + guess_matrix(i, j);
        end
        total = total + guess_matrix(i, j);
    end
end
accurate = success/total;
end