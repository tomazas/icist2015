function s_filtered = strip_artifacts(s,fs) % aux function - ensure we analyze only brain waves 7-30Hz
    s(isnan(s)) = 0;

    % REDUCE ARTIFACTS - filtering in specific range (7-30 Hz)
    [b,a] = butter(5, [7, 30]/(fs/2));
    s_filtered = filter(b, a, s);
end