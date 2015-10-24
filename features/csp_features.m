function [train_data, test_data] = mean_signal_power(p, train_trials, test_trials, train_labels, test_labels)
   
    [channels, samples, trials] = size(train_trials);
    
    % build training set
    train_data = zeros(trials, channels*2);
    for i=1:trials
        trial_samples = train_trials(:,:,i);
        for j=1:channels
            eeg = trial_samples(j,:);
            train_data(i,(j*2-1):(j*2)) = [mean(eeg) log(var(eeg))];
        end
    end

    % build testing set
    [channels, samples, trials] = size(test_trials);
    test_data = zeros(trials, channels*2);
    for i=1:trials
        trial_samples = test_trials(:,:,i);
        for j=1:channels
            eeg = trial_samples(j,:);
            test_data(i,(j*2-1):(j*2)) = [mean(eeg) log(var(eeg))];
        end
    end
end


