% extract features, classify them and verify correctness using 10xfold crossvalidation
function [training_err, testing_err, tenfold_train_err, tenfold_test_err] = eval_feats(p, feat_func, class_func, train_trials, test_trials, train_labels, test_labels)

    [train_data, test_data] = feat_func(p, train_trials, test_trials, train_labels, test_labels);

    [c, training_err] = class_func(p, test_data, train_data, train_labels);

    bad = (c ~= test_labels); %  compare classes with true labels
    testing_err = sum(bad) / length(test_labels); % error ratio
    
    % do 10-fold cross validation
    % crossval function can estimate the misclassification error for both LDA and QDA using the given data partition
    rng(0,'twister');
    
    cp = cvpartition(train_labels, 'k', 10) % generate 10 disjoint stratified subsets
    fun = @(xTrain,yTrain,xTest,yTest)(sum(class_func(p, xTest, xTrain, yTrain) ~= yTest));
    tenfold_train_err = sum(crossval(fun, train_data, train_labels, 'partition', cp))/sum(cp.TestSize)
    
    cp = cvpartition(test_labels, 'k', 10) % generate 10 disjoint stratified subsets
    fun = @(xTrain,yTrain,xTest,yTest)(sum(class_func(p, xTest, xTrain, yTrain) ~= yTest));
    tenfold_test_err = sum(crossval(fun, test_data, test_labels, 'partition', cp))/sum(cp.TestSize)
end
