%% Set random seed to make our experiments reproductible and load vlfeat library
rng(42);
% Linux path(Andrei and Stefan)
run('./vlfeat-0.9.21/toolbox/vl_setup');

% Dragos path(windows)
%run('C:/Program Files/MATLAB/R2018b/vlfeat-0.9.21-bin/toolbox/vl_setup')

%% Remove unwanted classes from dataset and save result to disk. Only need to run once
%remove_classes();

%% Extract sift (grayscale) features and save them to disk. Only need to run once
%feature_extraction();

load('stl10_matlab/grayscale_sifts.mat');

%% Run kmeans. The cluster centroids will represent our vocabulary
% [indexes, centroids] = kmeans(train_features, 1000);
% save('stl10_matlab/centroids1000.mat', 'centroids');


%% Build bag of visual words histograms
load('stl10_matlab/centroids1000.mat');
load('stl10_matlab/train_curated.mat');

[imghists,labels] = create_histograms(centroids,X_train,y_train);

%% Train SVM
models = training_SVM(imghists,labels);

%% Classification


