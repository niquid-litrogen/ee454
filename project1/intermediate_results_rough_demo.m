load 'data_files/CNNparameters.mat' biasvectors filterbanks layertypes;
load 'data_files/cifar10testdata.mat'

%pick an arbitrary image to observe intermediate results for
im_idx = round(10000*rand);

%pick an arbitrary layer to show results for (be careful that this doesn't
%cause any problems for certain layers). I recommend not doing this for the
%fully connected and soft max outputs, because those are less interpretable
%as images. It will actually be most interesting to observe images at the
%output of layer 2, because further down the line they get less
%interpretable, and a lot smaller. For example, it would be neat to take a
%few example images, pass them through the second layer, and display a grid
%of images where each image is a separate channel of the output. Then, each
%image corresponds to the output of a separate filter in the filterbank.
%That would be cool to put in the report and write observations about. 
layer_num = 2;

%select a channel from intermediate result to display. Unfortunately, you
%can't display a 10 channel array as an rgb image.  
display_channel = 8;

im = imageset(:,:,:,im_idx); 
orig_im = im;

for i = 1:layer_num
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
f1 = figure(1);
imagesc(orig_im);
%scale display size so the image does not look overly big.
truesize(gcf,[size(orig_im,1) * 6 ,size(orig_im,2) * 6]);
title(['Random Original Image (#' num2str(im_idx) ')']);
%Position image off to the side
movegui(f1, [50, 400]);

f2 = figure(2);
imagesc(im(:,:,display_channel));
%scale display size so the image does not look overly big.
truesize(gcf,[size(im,1) * 6,size(im,2) * 6]);
title({['Intermediate Result:'], ['Layer '  num2str(layer_num) ', Display Channel ' num2str(display_channel)]});
%Position image off to the side
movegui(f2, [50, 50]);



