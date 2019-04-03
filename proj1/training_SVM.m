function models = training_SVM(imghists,labels)
    classes = [1,2,3,7,9];
    for i=1:5
        % get binary labels
        binary_labels = double(labels == classes(i)); 
        % train SVM  with cross-validation
        aux = train(binary_labels, sparse(imghists) ,'-C -s 2');
        models(i) = train(binary_labels, sparse(imghists) , sprintf('-c %f -s 2', aux(1))); 
       
    end    
    
end

