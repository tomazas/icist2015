% Matlab linear discriminant analysis classifier
function [c, training_err] = classify_lda(p, test_data, train_data, train_labels)
	[c, training_err, post, logl, str] = classify(test_data, train_data, train_labels, 'linear');
end