function models = training_SVM(imghists,labels)
    classes = [1,2,3,7,9];
    for i=1:5
        binary_labels = double(labels == classes(i));    
        models(i) = train(binary_labels, sparse(imghists) ,'-s 0');    
    end
end

