function [train_data, test_data] = mean_teager_features(p, train_trials, test_trials, train_labels, test_labels)

    [channels, samples, trials] = size(train_trials);
	
	% training set
    train_data = zeros(trials, channels);
    for i=1:trials
        trial_samples = train_trials(:,:,i);
        for j=1:channels
            row = trial_samples(j,:);
            train_data(i,j) = mean(teager(row));
        end
    end

    % build testing set
    [channels, samples, trials] = size(test_trials);
    test_data = zeros(trials, channels);
    for i=1:trials
        trial_samples = test_trials(:,:,i);
        for j=1:channels
            row = trial_samples(j,:);
            test_data(i,j) = mean(teager(row));
        end
    end
end


