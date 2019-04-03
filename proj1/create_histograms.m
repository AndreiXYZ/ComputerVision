function imghists = create_histograms(centroids,featuretype)
    % load the right dataset
    switch featuretype
        case 'test'
            switch centroids.colorspace       
                case 'opp'
                    load('stl10_matlab/test_opponent.mat');
                    [num_train_images, ~] = size(X_test_opponent);
                    X = X_test_opponent; 

                otherwise
                    load('stl10_matlab/test_curated.mat');
                    [num_train_images, ~] = size(X_test);
                    X = X_test; 
            end
        otherwise
            switch centroids.colorspace       
                case 'opp'
                    load('stl10_matlab/train_opponent.mat');
                    [num_train_images, ~] = size(X_train_opponent);
                    X = X_train_opponent; 

                otherwise
                    load('stl10_matlab/train_curated.mat');
                    [num_train_images, ~] = size(X_train);
                    X = X_train; 
            end
    end  
    
    % get the size of the datasets
    switch featuretype
        case 'test'
            start = 1;
            stop = num_train_images;        
        otherwise
            start = num_train_images/2+1;
            stop = num_train_images;
    end
    
    
    imghists = [];
    for i=start:stop
        idx = (i+1) - start;
        img = unflatten_image(X(i,:));
        img = im2double(img);
        %turn to grayscale and singular
        grayscale_img = single(rgb2gray(img));
        [f,~] = vl_sift(grayscale_img);
        switch centroids.colorspace
            case 'grayscale'                
                %get descriptors
                if strcmp(centroids.extraction,'keypoints')
                    [~,d] = vl_sift(grayscale_img);
                else
                    [~,d] = vl_dsift(grayscale_img, 'step', 15);
                end                
                %transpose so that each descriptor is a row
                d=double(d');
               
                indexes = knnsearch(centroids.centroid, d);                
                %Now encode each image as a bag of words.              
                imghists(idx,:) = histcounts(indexes, 1:length(centroids.centroid)+1,...
                                           'Normalization', 'probability');
                          
            otherwise
                %get descriptors
                if strcmp(centroids.extraction,'keypoints')
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
                
                indexes = knnsearch(centroids.centroid, d);                
                %Now encode each image as a bag of words.              
                imghists(idx,:) = histcounts(indexes, 1:length(centroids.centroid)+1,...
                                           'Normalization', 'probability');
            
        end       
    end  
end


