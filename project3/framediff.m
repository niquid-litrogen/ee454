function [B1, outimg] = framediff(B0, frame, abs_diff_threshold)
    diff = abs(B0 - frame);
    outimg = threshold(diff, abs_diff_threshold);
    B1 = frame;
end