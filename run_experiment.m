% runs all tests for passed feature function and classifier function
function [xfold_kappas] = run(feat_func, class_func, p)

	addpath('features/');
    addpath('classifiers/')
	addpath('utils/');
    addpath('other/');
    addpath('libsvm/matlab/');

	% structure of the signal
    % S = struct:
    %             sig1: [672528x22 double]
    %             sig2: [687000x22 double]
    %      train_feats: [22x626x288 double]
    %       test_feats: [22x626x281 double]
    %     train_labels: [288x1 double]
    %      test_labels: [281x1 double]
    %               h1: [1x1 struct]
    %               h2: [1x1 struct]
    
    all_kappas = zeros(1,p.n);
    xfold_kappas = zeros(1,p.n);
    
    for i=1:p.n
        filename = sprintf(p.datadir, i);
        fprintf('>>> Loading signal: %s\n', filename);
        S = load(filename); % implement caching?
        
        s1 = S.sig1;
        s2 = S.sig2;

        fprintf('  Extracting features...\n');
        [preprocessed_signal_1, train_trials, csp_mat] = get_trials(s1, S.h1, p, 0);
        p.csp_matrix = csp_mat; % save computed CSP matrix for later use
        [preprocessed_signal_2, test_trials] = get_trials(s2, S.h2, p, 0);

        fprintf('  Removing artifacts from test data...\n');
        test_trials = test_trials(:,:,S.h2.ArtifactSelection==0); % preprocess also test_trials in data files and remove this
        %S.test_labels = S.test_labels(S.h2.ArtifactSelection==0); % S.test_labels are already preprocessed
        
        % normalize: 0 mean and unit variance
        train_trials = normalize(train_trials);
        test_trials = normalize(test_trials);
		
		% allow to do some other computation on input data (e.g. analysis)
        if isfield(p, 'analyze')
            fprintf('Analyzing data with: %s\n', func2str(p.analyze));
            p.analyze(train_trials, test_trials, S.train_labels, S.test_labels);
            continue;
        end

		fprintf('Evaluating: features - %s, classifier - %s...\n', func2str(feat_func), func2str(class_func));
        [training_err, testing_err, tfold_train_err, tfold_test_err] = eval_feats(p, feat_func, class_func, ...
            train_trials, test_trials, S.train_labels, S.test_labels);
      
        fprintf('Iteration %d:\n', i);
        train_accuracy = 1 - training_err;
        test_accuracy = 1 - testing_err;
        kappa = max((test_accuracy - 0.25) / 0.75, 0);
        fprintf('  Classify accuracy - train: %.4f test: %.4f kappa: %.4f\n', train_accuracy, test_accuracy, kappa);
        
        tfold_train_accuracy = 1 - tfold_train_err;
        tfold_test_accuracy = 1 - tfold_test_err;
        tfold_kappa = max((tfold_test_accuracy - 0.25) / 0.75, 0);
        fprintf('  Validate 10-fold  - train: %.4f test: %.4f kappa: %.4f\n', tfold_train_accuracy, tfold_test_accuracy, tfold_kappa);
        
        all_kappas(i) = kappa
        xfold_kappas(i) = tfold_kappa
    end
    
    if mean(all_kappas) > 0
        fprintf('mean kappa: %.4f, mean 10-fold kappa: %.4f\n', mean(all_kappas), mean(xfold_kappas));
    end
end



