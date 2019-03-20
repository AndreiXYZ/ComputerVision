function scores = classification(imghists, labels, models)
    classes = [1,2,3,7,9];
    ground_truth = [];
    predicted = [];
    accuracies = [];
    scores = [];
    for i=1:length(models)
        binary_labels = double(labels == classes(i));
        [~, ~,  score] = predict(binary_labels, sparse(imghists), models(i));
        if models(i).Label(1) == 0
            score = -score; 
        end       
        scores = [scores,score];        
    end
    scores = -scores;
    
end

