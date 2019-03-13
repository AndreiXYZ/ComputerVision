run('./vlfeat-0.9.21/toolbox/vl_setup');
load('stl10_matlab/train.mat');

[num_train_images, dim] = size(X);


train_features = zeros(1,1);

train_features = zeros(1,1);
for i=1:num_train_images
    img = unflatten_image(X(i,:));
    %get grayscale sift features
    [f,d] = vl_sift(single(rgb2gray(img)));
    %append them to matrix and save them to .mat file
    %TODO
end