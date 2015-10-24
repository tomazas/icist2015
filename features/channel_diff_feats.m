% implementation of channel difference filtering for feature generation
function [train_data, test_data] = channel_diff_feats(p, train_trials, test_trials, train_labels, test_labels)
   
    [channels, samples, trials] = size(train_trials);
    
    ch = [8 10 12 20];
    ky = [
        2   3  9  15 14  7  0  0; ...
        3   4  5   9 11 15 16 17; ...
        5   6  11 13 17 18  0  0; ...
        15 16  17 19 21 22  0  0
    ];
    weights = [
        1 0.5 1 0.5 1 1 0 0; ...
        0.5 1 0.5 1 1 0.5 1 0.5; ...
        0.5 1 1 1 0.5 1 0 0; ...
        0.5 1 0.5 1 1 1 0 0; ...
    ];

    bands = [8 14; 14 19; 19 24; 24 30];
    w = 0.5;
    mode = 2;
    
    function res = process(trial_samples, j)
        % Laplace filter
        mid = sum(weights(j,:))*trial_samples(ch(j),:);
        for k=1:size(ky, 2)
            if ky(j, k) > 0
                mid = mid - trial_samples(ky(j, k),:)*weights(j, k);
            end
        end

        % mean power of signal
        bp = bandpower(mid', p.fs, bands, w, mode);
        res = mean(bp);
    end

    N = size(bands,1);
    
    % build training set
    train_data = zeros(trials, length(ch)*N);
    for i=1:trials
        trial_samples = train_trials(:,:,i);
        for j=1:length(ch)
            train_data(i,(j*N-(N-1)):(j*N)) = process(trial_samples, j);
        end
    end

    % build testing set
    [channels, samples, trials] = size(test_trials);
    test_data = zeros(trials, length(ch)*N);
    for i=1:trials
        trial_samples = test_trials(:,:,i);
        for j=1:length(ch)
            test_data(i,(j*N-(N-1)):(j*N)) = process(trial_samples, j);
        end
    end
end


