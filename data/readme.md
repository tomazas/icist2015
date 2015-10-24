Preprocessed BCI IV 2008 2a dataset
--------------
This directory contains pre-processed BCI IV 2008 2a dataset (more info in docs/desc_2a.pdf).

The original *.gdf files found in BCI IV competition 2a dataset 
were converted to matlab .mat format for easier handling/loading.
File AT0x.gdf.mat corresponds to x-th analyzed subject.

Each .mat file contains a structure as described below:

S = struct:
             sig1: [672528x22 double]
             sig2: [687000x22 double]
      train_feats: [22x626x288 double]
       test_feats: [22x626x281 double]
     train_labels: [288x1 double]
      test_labels: [281x1 double]
               h1: [1x1 struct]
               h2: [1x1 struct]
			   
where:
  S.sig1 - original training signal (22 EEG channels, 250Hz sampling freq.)
  S.sig2 - original testing signal (22 EEG channels, 250Hz sampling freq.)
  S.train_feats - extracted training trials (22 channels, 288 trials, each signal is 626 samples)
  S.test_feats - extracted testing trials (22 channels, 281 trials, each signal is 626 samples)
  S.train_labels - classes for each training trial
  S.test_labels - classes for each testing trial
  S.h1 - structure h information (as in BCI IV 2a) that can be used to manually extract trials from S.sig1
  S.h2 - structure h information (as in BCI IV 2a) that can be used to manually extract trials from S.sig2
