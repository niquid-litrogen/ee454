function proj3main(dirstring, maxframenum, abs_diff_threshold, alpha_parameter, gamma_parameter)
%Take an input video (stored in a directory of images), perform four
%background subtraction algorithms, and store output video in a separate
%directory of images. Note that all four algorithm results are displayed in
%a single video.
%inputs:
%    dirstring: String specifying where input video is stored. It is
%               assumed that input video is a sequence of images with the
%               title format f0001.jpg,f0002.jpg, ...
%    maxframenum: Number of last frame in input video to process.
%    abs_diff_threshold: Number between 0 and 255, this value specifies the
%                        threshold for converting frame differences to binary values.
%    alpha_parameter: Floating point number between 0 and 1, used to
%                     control blending in adaptive background subtraction.
%    gamma_parameter: Number between 0 and 255, which controls how quickly
%                     detected motion fades away in persistent frame differencing.
%outputs:
%    A new directory, called 'output_images', is created and used to store
%    the output video. The video is written as a sequence of images with
%    the title format out0001.jpg, out0002.jpg, ... . Note that each frame
%    contains the results of all 4 algorithms, with one result per image
%    quadrant.

%Create output directory, for storage of result images
[x, y, z] = mkdir('output_images'); %xyz used to suppress warning if directory exists

%Read in initial frame and convert to grayscale by selecting green channel.
picname = 'f0001.jpg'; %inital filename for input video
imloc = [dirstring '/' picname];
B0 = imread(imloc);
%Convert to double and extract green channel. "double" is used as
%a standard array type for math operations.
B0 = double(B0(:, :, 3)); %green channel

%Initialize BG frames for each function
bgB0 = B0; %background frame for background subtraction
framediffB0 = B0; %background frame for frame differencing
adapB0 = B0; %background frame for adaptive background subtraction
persistB0 = B0; %background frame for persistent frame differencing
p_framediff_out = 0; %initial "H" input for persistent frame differencing
%write initial output frame
outname = ['out' num2str(1, '%04.f') '.jpg'];
outloc = ['output_images' '/' outname];
%Because the first input frame IS the initial background, write out the 
%first output frame as all 0s (entirely black) for no detected motion.
out_init = zeros(size(B0));
imwrite([out_init,out_init; out_init, out_init], outloc);

%Iterate through each input frame, perform background subtraction
%algorithms, and write results to output directory. Start iteration at
%frame 2 because frame 1 is used as background initialization.
for i=2:maxframenum
    %set current input frame filename
    picname  = ['f' num2str(i, '%04.f') '.jpg'];
    imloc = [dirstring '/' picname];
    %read input frame from file location
    It = imread(imloc);
    It = double(It(:, :, 3)); %use "double" as standard for math operations
    
    %Perform each motion detection algorithm
    %background subtraction
    bgsub_out = bgsub(bgB0, It, abs_diff_threshold);
    %frame differencing
    [framediffB0, framediff_out] = framediff(framediffB0, It, abs_diff_threshold);
    %adaptive bacground subtraction
    [adapB0, adaptivebg_out] = adaptivebg(adapB0, It, alpha_parameter, abs_diff_threshold);
    %persistent frame differencing
    [persistB0, p_framediff_out] = persistframediff(persistB0, It, abs_diff_threshold, gamma_parameter, p_framediff_out);
    
    %Write output frame, with each algorithm result in a separate quadrant.
    %Divide "p_framediff_out" by 255 to keep all values in the range of 0 and 1.
    final_out = [bgsub_out, framediff_out; adaptivebg_out, (1/255)*p_framediff_out];
    outname = ['out' num2str(i, '%04.f') '.jpg'];
    outloc = ['output_images' '/' outname];
    imwrite(final_out, outloc);
end

end