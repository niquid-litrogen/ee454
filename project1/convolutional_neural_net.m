function probabilities = convolutional_neural_net(im)
% Input: color_im is an NxMxD array representing a color image
%
% Output: probabilities is a vector of probabilities, one per object class.
% Higher probabilities means it is more likely that the picture contains 
% that kind of object. 
%
% Runs the main script for the convolutional neural net (CNN). This
% operates a chain of simple image processing operations to estimate
% probabilities of what object the input image depicts. 


load 'data_files/CNNparameters.mat' biasvectors filterbanks layertypes;


for i = 1:length(layertypes)
    switch layertypes{i}
        case 'imnormalize'
            im = apply_imnormalize(im);
        case 'relu'
            im = apply_relu(im);
        case 'maxpool'
            im = apply_maxpool(im);
        case 'convolve'
            im = apply_convolve(im, filterbanks{i}, biasvectors{i});
        case 'fullconnect'
            im = apply_fullconnect(im, filterbanks{i}, biasvectors{i});
        case 'softmax'
            probabilities = apply_softmax(im);
    end
end

end