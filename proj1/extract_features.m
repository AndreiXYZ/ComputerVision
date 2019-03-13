run('./vlfeat-0.9.21/toolbox/vl_setup');
load('stl10_matlab/train.mat');

first_img = X(1,:);
first_img = unflatten_image(first_img);
imshow(first_img);
first_img = flatten_image(first_img);