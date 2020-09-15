function outmatrix = guessmatrix(guessnum, probability, reality)
    outmatrix = zeros(10, 10);
    for i=1:length(reality)
        [B, I] = sort(probability(i,:), 'descend');
        row = reality(i);
        col = I(guessnum);
        outmatrix(row, col) = outmatrix(row, col) + 1;
    end

end