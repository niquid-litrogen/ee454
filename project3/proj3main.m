function proj3main(dirstring, maxframenum, abs_diff_threshold, alpha_parameter, gamma_parameter)

[x, y, z] = mkdir('output_images'); %xyz used to suppress warning if directory exists
picname = 'f0001.jpg'; %inital filename
imloc = [dirstring '/' picname];
B0 = imread(imloc);
B0 = double(B0(:, :, 3)); %green channel
% Initialize BG frames for each function
bgB0 = B0;
framediffB0 = B0;
adapB0 = B0;
persistB0 = B0;
p_framediff_out = 0;
outname = ['out' num2str(1, '%04.f') '.jpg'];
outloc = ['output_images' '/' outname];
imwrite([B0,B0; B0, B0], outloc);

for i=2:maxframenum
    %set current image filename
    picname  = ['f' num2str(i, '%04.f') '.jpg'];
    imloc = [dirstring '/' picname];
    %read image from file location
    It = imread(imloc);
    It = double(It(:, :, 3));
    %get values to run each method
    bgsub_out = bgsub(bgB0, It, abs_diff_threshold);
    
    [framediffB0, framediff_out] = framediff(framediffB0, It, abs_diff_threshold);
    
    [adapB0, adaptivebg_out] = adaptivebg(adapB0, It, alpha_parameter, abs_diff_threshold);
    
    [persistB0, p_framediff_out] = persistframediff(persistB0, It, abs_diff_threshold, gamma_parameter, p_framediff_out);
    
    final_out = [bgsub_out, framediff_out; adaptivebg_out, (1/255)*p_framediff_out];
    outname = ['out' num2str(i, '%04.f') '.jpg'];
    outloc = ['output_images' '/' outname];
    imwrite(final_out, outloc);
end


end