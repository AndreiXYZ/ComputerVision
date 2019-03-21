function features = feature_extraction(extraction,colorspace)    
    switch colorspace       
        case 'opp'
            load('stl10_matlab/train_opponent.mat');
            [num_train_images, ~] = size(X_train_opponent);
            X = X_train_opponent; 

        otherwise
            load('stl10_matlab/train_curated.mat');
            [num_train_images, ~] = size(X_train);
            X = X_train; 
    end 
        
    start = 1;
    stop = num_train_images/2;       
    
    %extract features from half of the training images
    features = [];
    for i=start:stop
        img = unflatten_image(X(i,:));
        img = im2double(img);
        %turn to grayscale and singular
        grayscale_img = single(rgb2gray(img));
        [f,~] = vl_sift(grayscale_img);
        switch colorspace
            case 'grayscale'                
                %get descriptors
                if strcmp(extraction,'keypoints')
                    [~,d] = vl_sift(grayscale_img);
                else
                    [~,d] = vl_dsift(grayscale_img, 'step', 15);
                end                
                %transpose so that each descriptor is a row
                d=double(d');
                %append them all to a matrix
                features = [features; d];                
                            
                
            otherwise
                %get descriptors
                if strcmp(extraction,'keypoints')
                    [~,d1] = vl_sift(single(img(:,:,1)), 'frames',f);
                    [~,d2] = vl_sift(single(img(:,:,2)), 'frames',f);
                    [~,d3] = vl_sift(single(img(:,:,3)), 'frames',f);
                else
                    [~,d1] = vl_dsift(single(img(:,:,1)), 'step', 15);
                    [~,d2] = vl_dsift(single(img(:,:,2)), 'step', 15);
                    [~,d3] = vl_dsift(single(img(:,:,3)), 'step', 15);
                end 
                d = cat(1,d1,d2,d3);
                %transpose so that each descriptor is a row
                d=double(d');
                %append them all to a matrix
                features = [features; d];           
            
        end       
    end   
end