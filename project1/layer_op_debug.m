%This script tests layer operations on the provided debugging data.
%Layers with incorrect outputs are displayed in the command window. If all
%layers provide correct outputs, no messages are displayed. 

load 'CNNparameters.mat';
load 'debuggingTest.mat';

num_layers = length(layertypes);

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