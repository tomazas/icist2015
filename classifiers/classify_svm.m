% libSVM SVM classifier
function [predict_label, training_err] = classify_svm(p, test_data, train_data, train_labels)
    model = svmtrain(train_labels, train_data, '-c 10 -g 0.07');
    
    fake_labels = zeros(size(test_data,1), 1); % since we don't know the true labels, pass fake ones
    [predict_label, accuracy, dec_values] = svmpredict(train_labels, train_data, model); % test the training data
    training_err = (100-accuracy(1))/100;
	[predict_label, accuracy, dec_values] = svmpredict(fake_labels, test_data, model); % test the testing data
end