function [B1, outimg] = adaptivebg(B0, frame, alpha, abs_diff_threshold)
    diff = abs(B0 - frame);
    outimg = threshold(diff, abs_diff_threshold);
    B1 = (alpha*frame) + (1-alpha)*B0;
end