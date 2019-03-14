function extract_features()
    %get size of training data
    load('stl10_matlab/train_curated.mat');
    [num_train_images, dim] = size(X_train);

    %extract features from half of the training images
    for i=1:round(num_train_images/2)
        img = unflatten_image(X_train(i,:));
        img = im2double(img);
        %turn to grayscale and singular
        grayscale_img = single(rgb2gray(img));
        %get keypoints
        [f,d] = vl_sift(grayscale_img);
        %Approximate the center of the circle to nearest integer
        f(1:2,:) = round(f(1:2,:));
        %transpose so that each descriptor is a row
        d=double(d');
        %append them all to a matrix
        if i==1
            train_features = d;
        else
            train_features = [train_features; d];
        end
    end
    
    %save the SIFT features to a .mat file
    save('stl10_matlab/grayscale_sifts.mat', 'train_features');
end