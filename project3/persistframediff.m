function [B1, outimg] = persistframediff(B0, frame, abs_diff_threshold, gamma, H)
%Perform one iteration of persistent frame differencing motion detection algorithm.
%Inputs:
%    B0: double MxN reference background frame for current iteration. This must be grayscale, with
%        values ranging from 0 to 255.
%    frame: double MxN input frame to modify. This must be grayscale, with values ranging from 0 to 255.
%    abs_diff_threshold: Positive scalar, between 0 and 255, specifying the difference 
%                        threshold for motion detection.
%    gamma: Scalar linear decay parameter, between 0 and 255, which controls how quickly detected
%           motion fades away.
%    H: double MxN grayscale output image from previous iteration. 
%Outputs:
%    B1: double MxN grayscale image. This is the reference background to be used in next iteration, which is the
%        same as input frame in current iteration.
%    outimg: double MxN grayscale image. This is the output of current iteration, and the "H" input for next 
%            iteration. Note that values in this image range from 0 to 255, not 0 to 1.

    diff = abs(B0 - frame);
    
    %Detect motion in current frame. Note that the "threshold" operation
    %converts image to binary.
    Mt = threshold(diff, abs_diff_threshold);
    
    %apply decay to motion from previous output. This has the effect of
    %making detected motion fade out over time. 
    tmp = max(H-gamma,0);
    
    %Combine previous output with detected motion in current input.
    %Multiply Mt by 255 so that pixel values are on the same scale as tmp.
    outimg = max(255*Mt, tmp);
    B1 = frame;
end