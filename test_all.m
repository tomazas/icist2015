% tests passed feature function with all existing classifiers defined in their folder
function test_all(feat_func, params, outname, restrict)
	% find and test all classifiers
	listing = dir('classifiers/*.m');
    
    % output results to CSV file
	fp = fopen(outname, 'wt');
	fprintf(fp, 'sep=;\n'); % ensure delimiter is correct
    
	for i = 1:length(listing)
		name = listing(i).name(1:end-2);
		
		% check if we need to test one specific classifier only
		if nargin > 3 && strcmp(name, restrict) ~= 1
			continue;
		end
		
		fprintf('[#%d: Testing classifier: %s]\n', i, name);
        fprintf(fp, '%s;', name); 
		
		kappas = run_experiment(feat_func, str2func(name), params);
        
		% file output
        for j=1:length(kappas)
            fprintf(fp, '%.4f;', kappas(j));
        end
        fprintf(fp, '%.4f\n', mean(kappas));
    end
    
    fclose(fp);
    
    fprintf('Test All: Complete!\n');
end