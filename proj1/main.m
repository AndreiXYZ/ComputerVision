%% Set random seed to make our experiments reproductible and load vlfeat library
rng(42);
% Linux path(Andrei and Stefan)
run('./vlfeat-0.9.21/toolbox/vl_setup');

% Dragos path(windows)
%run('C:/Program Files/MATLAB/R2018b/vlfeat-0.9.21-bin/toolbox/vl_setup')

% Traian path(windows)
%run('D:/MscAI/2nd Semester 1st Period/Computer Vision 1/ComputerVision/proj1/vlfeat-0.9.21/toolbox/vl_setup');

%% Remove unwanted classes from dataset and save result to disk. Only need to run once
%remove_classes();

%% Extract sift (grayscale) features and save them to disk. Only need to run once
%feature_extraction();

load('stl10_matlab/grayscale_sifts.mat');

%load('stl10_matlab/grayscale_sifts.mat');
%% Extract sift (rgb) features and save them to disk. Only need to run once
%feature_extraction_rgb();

%load('stl10_matlab/rgb_sifts.mat');

%% Run kmeans. The cluster centroids will represent our vocabulary
% [indexes, centroids] = kmeans(train_features, 1000);
% save('stl10_matlab/centroids1000.mat', 'centroids');


%% Build bag of visual words histograms
load('stl10_matlab/centroids1000.mat');
load('stl10_matlab/train_curated.mat');

[imghists_train,labels_train] = create_histograms(centroids,X_train,y_train,size(X_train,1)/2);

%% Train SVM
models = training_SVM(imghists_train,labels_train);
%save('stl10_matlab/models.mat', 'models');

%% Classification and ranking lists
load('stl10_matlab/test_curated.mat');
%load('stl10_matlab/models.mat');

[imghists_test,labels_test] = create_histograms(centroids,X_test,y_test,0);
scores = classification(imghists_test,labels_test,models);

[rankings, top5, bottom5] = ranking_lists(scores,labels_test);

%% Get MAP
[maps,mean_map] = getMap(rankings);








