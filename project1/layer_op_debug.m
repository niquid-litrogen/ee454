%This script tests layer operations on the provided debugging data.

%TEST 1:
%Check that each layer outputs the correct result, given the correct input.
%A message in the command window displays whether or not each layer passes the test. 

load 'data_files/CNNparameters.mat';
load 'data_files/debuggingTest.mat';

num_layers = length(layertypes);

%Perform each layer operation in sequence, using the correct input at each
%stage.
for i = 1:1:num_layers
    layertype = layertypes{i};
    layerout = layerResults{i};
    
    %perform layer operation specified by 'layertype' cell array at
    %position i. Note that, for all operations except for imnormalize, the
    %correct input is stored in cell i-1 of layerout.
    switch layertype
        %need to use imrgb as layer input to imnormalize
        case 'imnormalize'
            testout = apply_imnormalize(imrgb);
   
        case 'relu'
            testin = layerResults{i-1};
            testout = apply_relu(testin);
    
        case 'maxpool'
            testin = layerResults{i-1};
            testout = apply_maxpool(testin);
    
        case 'convolve'
            testin = layerResults{i-1};
            filters = filterbanks{i};
            bias = biasvectors{i};
            testout = apply_convolve(testin,filters,bias);
    
        case 'fullconnect'
            testin = layerResults{i-1};
            filters = filterbanks{i};
            bias = biasvectors{i};
            testout = apply_fullconnect(testin,filters,bias);
    
        case 'softmax'
            testin = layerResults{i-1};
            testout = apply_softmax(testin);
      
    end
    
    %check thresholded absolute difference due to float precision effects from
    %convolve, softmax, and fullconnect layers
    if not (all(abs(testout - layerout) < 10 * eps, 'all'))
        disp(sprintf('layer %d failed', i));
    else
        disp(sprintf('layer %d succeeded', i));
    end
end

%TEST 2:
%Check that, when doing a full forward pass on debug image, the layer
%operations produce the correct final result. A message is displayed 
%indicating whether or not the test is passed.
full_pass = convolutional_neural_net(imrgb);

%check that output of full end-to-end pass is equal to the provided final result,
%within tolerance of 10 * eps
if all(abs(full_pass - layerResults{num_layers}) < 10 * eps, 'all')
    disp('correct final output of full pass');
else
    disp('incorrect final output of full pass');
end