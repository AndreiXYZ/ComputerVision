function feature_extraction_rgb()
    %get size of training data
    load('stl10_matlab/train_curated.mat');
    [num_train_images, dim] = size(X_train);

    %extract features from half of the training images
    for i=1:round(num_train_images/2)
        img = unflatten_image(X_train(i,:));
        
        %turn image to singular 
        single_img = im2single(img);
     
        channel_descriptors = [];
        for channel = 1:3
            [~,d] = vl_sift(single_img(:,:,channel));
            
            %transpose so that each descriptor is a row
            d=double(d');
            channel_descriptors = [channel_descriptors; d];
        end

        %append them all to a matrix
        if i==1
            train_features = channel_descriptors;
        else
            train_features = [train_features; channel_descriptors];
        end
    end
    
    %save the SIFT features to a .mat file
    save('stl10_matlab/rgb_sifts.mat', 'train_features');
end
