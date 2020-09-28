function generate_excel(guess_matrices, classlabels)
filename = 'confusion_matrices.xlsx';
for i=1:10
    sheetname = ['Probability #' num2str(i)];
    guessnum = ['#' num2str(i)];
    writematrix(guessnum, filename, 'Sheet', sheetname, 'Range', 'A1');
    writematrix(guess_matrices(:,:,i), filename, 'Sheet', sheetname, 'Range', 'C3');
    writecell(classlabels, filename, 'Sheet', sheetname, 'Range', 'C2');
    writecell(reshape(classlabels, [10 1]), filename, 'Sheet', sheetname, 'Range', 'B3');
end