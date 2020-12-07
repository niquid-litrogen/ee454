function [B1, outimg] = framediff(B0, frame, abs_diff_threshold)
%Perform one iteration of frame differencing motion detection algorithm.
%Inputs:
%    B0: double MxN reference background frame for current iteration. This must be grayscale, with
%        values ranging from 0 to 255.
%    frame: double MxN input frame to modify. B0 is subtracted from this frame.
%           This must be grayscale, with values ranging from 0 to 255.
%    abs_diff_threshold: Positive scalar, between 0 and 255, specifying the 
%                        difference threshold for motion detection. 
%Outputs:
%    B1: double MxN grayscale image. This is the reference background to be used in next iteration. For frame
%        differencing, this is the same as input "frame".
%    outimg: MxN binary image. A pixel with a value of '1' indicates
%            detected motion.

    diff = abs(B0 - frame);
    %Convert 'diff' to binary image. Pixels with values > abs_diff_threshold are set to 1, indicating motion. 
    outimg = threshold(diff, abs_diff_threshold);
    %Set current input as background for next iteration
    B1 = frame;
end