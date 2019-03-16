load('stl10_matlab/train_curated.mat');
load('stl10_matlab/test_curated.mat');

%transform all imgaes into opponent color space
for i=1:size(X_train,1)
    img = unflatten_image(X_train(i,:));
    img = rgb2opponent(img);
    img = flatten_image(img);
    X_train_opponent(i,:) = img;
end

%repeat for test data
for i=1:size(X_test,1)
    img = unflatten_image(X_test(i,:));
    img = rgb2opponent(img);
    img = flatten_image(img);
    X_test_opponent(i,:) = img;
end

save('stl10_matlab/train_opponent.mat', 'X_train_opponent');
save('stl10_matlab/test_opponent.mat',  'X_test_opponent');