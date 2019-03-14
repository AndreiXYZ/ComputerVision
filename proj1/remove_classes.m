%remove from X classes that are not in the following cateogires:
%airplanes, birds, ships,horses and cars
%removes unwanted classes from train.mat and test.mat and saves the result to disk
function remove_classes()
    load('stl10_matlab/train.mat')
    %remove from X and y rows that are not in classes [1,2,3,7,9]
    X(ismember(y,[4,5,6,8,10]),:) = [];
    y(ismember(y,[4,5,6,8,10]),:) = [];


    %rename them to a better format
    X_train = X;
    y_train = y;

    %print their sizes for sanity check
%     size(X_train)
%     size(y_train)

    %save them to disk
    save('stl10_matlab/train_curated.mat', 'X_train', 'y_train');

    %repeat for test data
    load('stl10_matlab/test.mat');

    X(ismember(y,[4,5,6,8,10]),:) = [];
    y(ismember(y,[4,5,6,8,10]),:) = [];

    X_test = X;
    y_test = y;

%     size(X_test)
%     size(y_test)
    save('stl10_matlab/test_curated.mat', 'X_test', 'y_test');