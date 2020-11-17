function [B1, outimg] = persistframediff(B0, frame, abs_diff_threshold, gamma, H)
    diff = abs(B0 - frame);
    Mt = threshold(diff, abs_diff_threshold);
    tmp = max(H-gamma,0);
    outimg = max(255*Mt, tmp);
    B1 = frame;
end