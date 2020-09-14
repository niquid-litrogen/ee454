function accurate = guessaccuracy(guess_matrix)
    success = 0;
    total = 0; 
    for i=1:size(guess_matrix, 1)
        for j=1:size(guess_matrix, 2)
            if(j == i)
                total = total + guess_matrix(i, j);
            else
                success = success + guess_matrix(i, j);
            end
        end
    end
    accurate = total/success;
end