% Matlab quadratic discriminant analysis classification
function [c, training_err] = classify_qda(p, test_data, train_data, train_labels)
	[c, training_err, post, logl, str] = classify(test_data, train_data, train_labels, 'quadratic');
end