function [train_data, test_data] = mean_tdp_features(p, train_trials, test_trials, train_labels, test_labels)

    [channels, samples, trials] = size(train_trials);
	
	function [f] = tdp_extract(s) % helper function
		d = 5;
		u = 0.015;
		params.feat.subtype = 'log-power';
		subtype = 'log-power';
		
		[ff, gg] = tdp(s, d, u);
		if (strcmp(subtype, 'log-power'))
			f = ff;
		elseif strcmp(subtype, 'log-amplitude')
			f = gg;
		elseif strcmp(subtype, 'log-power+log-amplitude')
			f = [ff, gg];
		end
	end

	% training set
    train_data = zeros(trials, channels);
    for i=1:trials
        trial_samples = train_trials(:,:,i);
        for j=1:channels
            row = trial_samples(j,:);
			feats = tdp_extract(row);

            feats(isnan(feats)) = 0; % remove NaN
            train_data(i,j) = mean(feats);
        end
    end

    % build testing set
    [channels, samples, trials] = size(test_trials);
    test_data = zeros(trials, channels);
    for i=1:trials
        trial_samples = test_trials(:,:,i);
        for j=1:channels
            row = trial_samples(j,:);
			feats = tdp_extract(row);
            
            feats(isnan(feats)) = 0; % remove NaN
            test_data(i,j) = mean(feats);
        end
    end
    
end


