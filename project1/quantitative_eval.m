% A functio to evaluate the effectiveness of the CNN.
% Generates an array containing probabilities for each image, then matches
% those to a given "guess number". So guess number 1 is the highest
% probability, guess #2 is the second highest, and so on. This allows us to
% creat the confusion matrix, as well as other matrices that ultimately can
% be used to plot classification accuracy.

clear;
clc;
load 'data_files/cifar10testdata.mat' classlabels imageset trueclass;
imgNum = length(trueclass);
prob = zeros(imgNum, length(classlabels));
for i=1:length(trueclass)
    prob(i, :) = convolutional_neural_net(imageset(:,:,:,i));
end

confusion_matrix = guessmatrix(1, prob, trueclass);
guess_matrices = zeros(10,10,10);
guess_matricies(:, :, 1) = confusion_matrix;
for k=2:10
    guess_matrices(:,:,k) = guessmatrix(k, prob, trueclass);
end

