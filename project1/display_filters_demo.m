%Display RGB filters for first convolution layer of neural network. Filters in deeper layers layers of the 
%classfier are not displayed, because they do not process the image directly and are therefore harder to interpret.

%load pretrained model parameters
load 'data_files/CNNparameters.mat'

%Extract filters from first conv layer
filts = filterbanks{2};

%Display each of 10 filters in a separate cell of a 2x5 image.
for i = 1:10
    filt_rgb = filts(:,:,:,i);
    subplot(2,5,i);
    
    %Display rgb image, and set it to fit the entire subplot.
    %Reference: https://www.mathworks.com/help/images/ref/truesize.html
    imshow(filt_rgb,'Initialmagnification','fit');
    title(sprintf('filter %d',i));
end

sgtitle("RGB Filters in First Convolution Layer of CNN");