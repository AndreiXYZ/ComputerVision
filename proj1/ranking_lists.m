function [rankings, top5, bottom5] = ranking_lists(scores,labels)
    classes = [1,2,3,7,9];
    rankings = [];
    top5 = [];
    bottom5 = [];
    for i=1:5        
        binary_labels = double(labels == classes(i));  
        aux = [scores(:,i), binary_labels]; 
        [sorted, img_indexes] = sortrows(aux, 1);
        ranking = sorted(:,2);
        rankings = [rankings,ranking]; 
        top5 = [top5; img_indexes(1)];
        bottom5 = [bottom5; img_indexes(end)];
    end
    
    
    
end
