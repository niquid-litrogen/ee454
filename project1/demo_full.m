% This demo evaluates the effectiveness of the CNN. It generates
% an array containing probabilities for each image, then matches
% those probabilities to a given "guess number". This allows us to find the 
% accuracy of the top k classes and plot the classification accuracy curve.
clear; clc; close all;
load 'data_files/cifar10testdata.mat' classlabels imageset trueclass;

%Initialize probability array
imgNum = length(trueclass);
prob = zeros(imgNum, length(classlabels));

%Find probabilities for each image
for i=1:imgNum
    prob(i, :) = convolutional_neural_net(imageset(:,:,:,i));
end



save('CNN_cifar_prob.mat', 'prob');


%Use our function "guessmatrix" to create a matrix that displays the
%accuracy of the CNN's k-th guess. So for k=1 the CNN's first guess, the
%highest probability, is used. For k=2 the second highest probability is
%used, and so on.
confusion_matrix = guessmatrix(1, prob, trueclass);
disp('Confusion Matrix for CNN:')
disp(confusion_matrix)
guess_matrices = zeros(10,10,10);
guess_matrices(:, :, 1) = confusion_matrix;

for k=2:10
    guess_matrices(:,:,k) = guessmatrix(k, prob, trueclass);
end

%Populate excel tables (used in report)
generate_excel(guess_matrices, classlabels);

%"guessaccuracy" simply gives the accuracy using the formula from the
%project description document - the sum of the diagonals over the sum of
%all entries in the array.

%The accuracy of the first guess is the accuracy of the confusion matrix
accuracy_score(1) = guessaccuracy(confusion_matrix);

for g=2:size(guess_matrices, 3)
    accuracy_score(g) = guessaccuracy(guess_matrices(:,:,g)) + accuracy_score(g-1);
end

%Show intermediate results
intermediate_results_rough_demo();
display_filters_demo();

%Plot results
figure;
k = 1:1:10;
plot(k, 100*accuracy_score, '-o');
xlabel("Top k ranked classes");
ylabel("Correct Classification %");
title("Classification Accuracy");
