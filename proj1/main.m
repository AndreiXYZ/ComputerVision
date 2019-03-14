%% Set random seed to make our experiments reproductible and load vlfeat library
rng(42);
run('./vlfeat-0.9.21/toolbox/vl_setup');

%% Remove unwanted classes from dataset and save result to disk. Only need to run once
%remove_classes();

%% Extract sift (grayscale) features and save them to disk. Only need to run once
%feature_extraction();

load('stl10_matlab/grayscale_sifts.mat');
size(train_features)
%run kmeans to build our vocabulary. 
%get cluster assignments and centroids of all descriptors
[indexes, centroids] = kmeans(train_features, 1000);
