% function doing kNN classification of data
function [c, training_err] = classify_knn(p, test_data, train_data, train_labels)
    k = 15;
    
    % create and train kNN model
    mdl = ClassificationKNN.fit(train_data, train_labels, 'NumNeighbors', k, 'Distance', 'euclidean');
    %train_accuracy = 1-resubLoss(mdl); % optimistic accuracy
    
    % 10-fold cross-validation
    cvmdl = crossval(mdl, 'kfold', 10);
    %train_accuracy = 1-kfoldLoss(cvmdl);
	training_err = kfoldLoss(cvmdl);
    
    % predict/classify
    [classified_labels, score, cost] = predict(mdl, test_data);
	c = classified_labels;
    %confusion_matrix = confusionmat(test_labels, classified_labels);
    
    %accuracy = sum(diag(confusion_matrix))/sum(sum(confusion_matrix));
end