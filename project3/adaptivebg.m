function [B1, outimg] = adaptivebg(B0, frame, alpha, abs_diff_threshold)
%Perform one iteration of adaptive background subtraction motion detection algorithm.
%Inputs:
%    B0: double MxN reference background frame for current iteration. This must be grayscale, with
%        values ranging from 0 to 255.
%    frame: double MxN input frame to modify. B0 is subtracted from this frame.
%           This must be grayscale, with values ranging from 0 to 255.
%    alpha: Scalar blending parameter specifying how much weight the current image
%           has in updating the background model. This must have a value
%           between 0 and 1.
%    abs_diff_threshold: positive scalar, between 0 and 255, specifying the difference 
%                        threshold for motion detection. 
%Outputs:
%    B1: double MxN grayscale image, reference background to be used in next iteration. This is a
%        convex combination of inputs "B0" and "frame".
%    outimg: MxN binary image. A pixel with a value of '1' indicates
%            detected motion.
    diff = abs(B0 - frame);
    %convert diff to binary image
    outimg = threshold(diff, abs_diff_threshold);
    %blend current image with current background to make background for next iteration
    B1 = (alpha*frame) + (1-alpha)*B0;
end