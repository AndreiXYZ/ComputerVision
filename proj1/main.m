%% Set random seed to make our experiments reproductible and load vlfeat library
rng(42);
run('./vlfeat-0.9.21/toolbox/vl_setup');

%% Remove unwanted classes from dataset and save result to disk. Only need to run once
%remove_classes();

%% Extract sift (grayscale) features and save them to disk. Only need to run once
%feature_extraction();

load('stl10_matlab/grayscale_sifts.mat');

%% Run kmeans. The cluster centroids will represent our vocabulary
% [indexes, centroids] = kmeans(train_features, 1000);
% save('stl10_matlab/centroids1000.mat', 'centroids');


%% Now build the bag of visual words from the rest of the images. This will be used to train our svm

load('stl10_matlab/centroids1000.mat');
num_train_images = size(X_train, 1);

%Use the other half of  the images to build bovw
size(train_features)
size(num_train_imgs)
for i=(num_train_images/2)+1:num_train_imgs
    img = X_train(i,:);
    img = unflatten_image(img);
    img = single(rgb2gray(im2double(img)));
    [f,d] = vl_sift(img);
    d = double(d');
    indexes = knnsearch(train_features, d);
    %Each row of indexes contains the index of the nearest
    %neighbor in train_features for the corresponding row in d.
    %Now encode each image as a bag of words.
    idx = i-num_train_images/2;
    %replace with counts
    imghists(idx,indexes) = 1;
end

size(imghists)


