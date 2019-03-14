function extract_features()
    %get size of training data
    load('stl10_matlab/train_curated.mat');
    [num_train_images, dim] = size(X_train);

    %extract features from half of the training images
    for i=1:round(num_train_images/2)
        img = unflatten_image(X_train(i,:));
        %turn to grayscale and singular
        img = single(rgb2gray(im2double(img)));
        %get grayscale sift features
        [f,d] = vl_sift(img);
        %transpose so that each descriptor is a row
        f = f';
        %append them all to a matrix
        if i==1
            train_features = f;
        else
            train_features = [train_features; f];
        end
    end
    
    %save the SIFT features to a .mat file
    save('stl10_matlab/grayscale_sifts.mat', 'train_features');
end