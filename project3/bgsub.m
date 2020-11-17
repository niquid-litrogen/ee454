function outimg = bgsub(B0, frame, abs_diff_threshold)
    diff = abs(B0 - frame);
    outimg = threshold(diff, abs_diff_threshold);
end