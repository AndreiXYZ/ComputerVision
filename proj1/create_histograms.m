function [imghists,labels] = create_histograms(centroids,X_train,y_train)    
    num_train_imgs = size(X_train, 1);    
    imghists = zeros(num_train_imgs/2,length(centroids));
    labels = zeros(num_train_imgs/2,1);
    
    for i=(num_train_imgs/2)+1:num_train_imgs
        img = X_train(i,:);
        img = unflatten_image(img);
        img = single(rgb2gray(im2double(img)));
        [~,d] = vl_sift(img);
        d = double(d');
        indexes = knnsearch(centroids, d);
        %Each row of indexes contains the index of the nearest
        %neighbor in train_features for the corresponding row in d.
        %Now encode each image as a bag of words.
        idx = i-num_train_imgs/2;        
        imghists(idx,:) = histcounts(indexes, 1:length(centroids)+1, 'Normalization', 'probability');
        labels(idx,1) = y_train(i,1);
        
    end
    
end


