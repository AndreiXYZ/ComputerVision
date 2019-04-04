%% main function 
pre_train = load('data/pre_trained_model.mat');
addpath('matconvnet-1.0-beta23/matlab');
addpath('liblinear-2.1/matlab');
addpath('tSNE_matlab');
vl_simplenn_display(pre_train.net);

%% fine-tune cnn
clc
%rmdir('data/cnn_assignment-lenet', 's');

[net, info, expdir] = finetune_cnn();
%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
nets.fine_tuned = load(fullfile(expdir, 'net-epoch-120.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-stl.mat'));
%vl_simplenn_display(nets.pre_trained);
%% we take only data from test.m 
% getting test data from the whole data
test_data = data.images.data(:,:,:,data.images.set == 2);
% getting labels data from the test data
test_labels = data.images.labels(:,data.images.set == 2);

%% for pre_trained

% removing softmax layer
my_net_pre_t.layers = nets.pre_trained.layers(:,1:end - 1);
% adding meta
my_net_pre_t.meta = nets.pre_trained.meta;

% run network for test data
forward = vl_simplenn(my_net_pre_t, test_data);
% getting features from last layer
features = (forward(12).x);
% getting rid of dimension of size 1
features = squeeze(features)';
%%
% running built in tsne
Y = tsne(features);
% plot the features in 2D for coresponding labels
gscatter(Y(:,1),Y(:,2),test_labels)
%% for fine_tuned

% removing softmax layer
my_net_fine_t.layers = nets.fine_tuned.layers(:,1:end - 1);
% adding meta
my_net_fine_t.meta = nets.fine_tuned.meta;

% run network for test data
forward = vl_simplenn(my_net_fine_t, test_data);
% getting features from last layer
features = (forward(12).x);
% getting rid of dimension of size 1
features = squeeze(features)';
%%
% running built in tsne
Y = tsne(features);
% plot the features in 2D for coresponding labels
gscatter(Y(:,1),Y(:,2),test_labels)
%%
train_svm(nets, data);
