function [train_data, test_data, train_lbl, test_lbl] = mean_signal_power(p, train_trials, test_trials, train_labels, test_labels)
   
    disp('Computing features');
    
    [channels, samples, trials] = size(train_trials);

    % build training set
    train_data = zeros(trials, channels);
    for i=1:trials
        trial_samples = train_trials(:,:,i);
        for j=1:channels
            row = trial_samples(j,:); % strip_artifacts(trial_samples(j,:), fs);
            train_data(i,j) = mean(row.^2); % mean power of signal
        end
    end

    % build testing set
    [channels, samples, trials] = size(test_trials);
    test_data = zeros(trials, channels);
    for i=1:trials
        trial_samples = test_trials(:,:,i);
        for j=1:channels
            row = trial_samples(j,:); %strip_artifacts(trial_samples(j,:), fs);
            test_data(i,j) = mean(row.^2); % mean power of signal
        end
    end
    
    train_data = log(train_data);
    test_data = log(test_data);
    
    train_lbl = train_labels;
    test_lbl = test_labels;
end


