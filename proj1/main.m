%% Set random seed to make our experiments reproductible and load vlfeat library
rng(42);
run('./vlfeat-0.9.21/toolbox/vl_setup');

%% Remove unwanted classes from dataset and save result to disk. Only need to run once
remove_classes();

%% Extract sift (grayscale) features and save them to disk. Only need to run once
feature_extraction();
