function [train_data, test_data] = mean_bp_features(p, train_trials, test_trials, train_labels, test_labels)
    % every channel contains signal power mean value
    [channels, samples, trials] = size(train_trials);

    bands = [8 14; 19 24; 24 30];
    w = 0.5; % window width
    mode = 2;
    
%    mode       mode == 1 uses FIR filter and log10
%               mode == 2 uses Butterworth IIR filter and log10
%               mode == 3 uses FIR filter and ln
%               mode == 4 uses Butterworth IIR filter and ln
    
    train_data = zeros(trials, channels);
    for i=1:trials
        trial_samples = train_trials(:,:,i);
        for j=1:channels
            row = strip_artifacts(trial_samples(j,:), p.fs);
            bp = bandpower(row', p.fs, bands, w, mode);
            train_data(i,j) = mean(mean(bp));
        end
    end

    % build testing set
    [channels, samples, trials] = size(test_trials);
    test_data = zeros(trials, channels);
    for i=1:trials
        trial_samples = test_trials(:,:,i);
        for j=1:channels
            row = strip_artifacts(trial_samples(j,:), p.fs);
            bp = bandpower(row', p.fs, bands, w, mode);
            test_data(i,j) = mean(mean(bp));
        end
    end
    
end


