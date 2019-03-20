function [imghists,labels] = create_histograms(centroids,X,y,start)       
    imghists = zeros(size(X, 1)-start,length(centroids));
    labels = zeros(size(X, 1)-start,1);
    
    for i=start+1:size(X, 1)
        img = X(i,:);
        img = unflatten_image(img);
        img = single(rgb2gray(im2double(img)));
        [~,d] = vl_sift(img);
        d = double(d');
        indexes = knnsearch(centroids, d);
        %Each row of indexes contains the index of the nearest
        %neighbor in train_features for the corresponding row in d.
        %Now encode each image as a bag of words.
        idx = i-start;        
        imghists(idx,:) = histcounts(indexes, 1:length(centroids)+1, 'Normalization', 'probability');
        labels(idx,1) = y(i,1);
        
    end
    
end


