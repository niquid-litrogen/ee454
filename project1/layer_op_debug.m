%This script tests layer operations on the provided debugging data.

%TEST 1:
%Check that each layer outputs the correct result, given the correct input.
%Layers with incorrect outputs are displayed in the command window. If all
%layers provide correct outputs, no messages are displayed. 

load 'CNNparameters.mat';
load 'debuggingTest.mat';

num_layers = length(layertypes);

%Perform each layer operation in sequence, using the correct input at each
%stage. If a layer produces an incorrect result, a message is displayed. If no
%layers produce incorrect results, no messages are displayed.
for i = 1:1:num_layers
    layertype = layertypes{i};
    layerout = layerResults{i};
    
    %need to use imrgb as layer input to imnormalize
    if (strcmp(layertype,'imnormalize'))
        testout = apply_imnormalize(imrgb);
        if not (all(testout == layerout, 'all'))
            disp(sprintf('layer %d failed', i))
        end
   
    elseif (strcmp(layertype,'relu'))
        testin = layerResults{i-1};
        testout = apply_relu(testin);
        if not (all(testout == layerout, 'all'))
            disp(sprintf('layer %d failed', i))
        end
    
    elseif (strcmp(layertype,'maxpool'))
        testin = layerResults{i-1};
        testout = apply_maxpool(testin);
        if not (all(testout == layerout, 'all'))
            disp(sprintf('layer %d failed', i))
        end
    
    elseif (strcmp(layertype,'convolve'))
        testin = layerResults{i-1};
        filters = filterbanks{i};
        bias = biasvectors{i};
        testout = apply_convolve(testin,filters,bias);
        %check absolute difference due to float precision
        if not (all(abs(testout - layerout) < 10 * eps, 'all'))
            disp(sprintf('layer %d failed', i))
        end
    
    elseif (strcmp(layertype,'fullconnect'))
        testin = layerResults{i-1};
        filters = filterbanks{i};
        bias = biasvectors{i};
        testout = apply_fullconnect(testin,filters,bias);
        if not (all(abs(testout - layerout) < 10 * eps, 'all'))
            disp(sprintf('layer %d failed', i))
        end
    
    elseif (strcmp(layertype,'softmax'))
        testin = layerResults{i-1};
        testout = apply_softmax(testin);
        if not (all(abs(testout - layerout) < 10 * eps, 'all'))
            disp(sprintf('layer %d failed', i))
        end        
        
    end
end

%TEST 2:
%Check that, when doing a full forward pass on debug image, the layer
%operations produce the correct final result. A message is displayed 
%indicating whether or not the test is passed.

%used to store output of previous layer, which is used as the input to the
%current layer
previous_out = [];

%perform each layer operation in sequence, with the sequence provided by
%the 'layertypes' cell array.
for i = 1:1:num_layers
    layertype = layertypes{i};
    layerfilter = filterbanks{i};
    layerbias = biasvectors{i};
    
    if (strcmp(layertype,'imnormalize'))
        layer_out = apply_imnormalize(imrgb);
   
    elseif (strcmp(layertype,'relu'))
        layer_out = apply_relu(previous_out);
    
    elseif (strcmp(layertype,'maxpool'))
        layer_out = apply_maxpool(previous_out);
    
    elseif (strcmp(layertype,'convolve'))
        layer_out = apply_convolve(previous_out,layerfilter,layerbias);
    
    elseif (strcmp(layertype,'fullconnect'))
        layer_out = apply_fullconnect(previous_out,layerfilter,layerbias);

    elseif (strcmp(layertype,'softmax'))
        layer_out = apply_softmax(previous_out);
        
    end
    
    previous_out = layer_out;
    
end    

final_out = previous_out;

%check that output of full end-to-end pass is equal to the provided final result,
%within tolerance of 10 * eps
if all(abs(final_out - layerResults{num_layers}) < 10 * eps, 'all')
    disp('correct final output of full pass')
else
    disp('incorrect final output of full pass')
end