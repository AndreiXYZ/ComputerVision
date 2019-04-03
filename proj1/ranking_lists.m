function [rankings, top5, bottom5] = ranking_lists(scores,labels)
    classes = [1,2,3,7,9];
    rankings = [];
    top5 = [];
    bottom5 = [];
    for i=1:5        
        % get binary labels
        binary_labels = double(labels == classes(i));  
        aux = [scores(:,i), binary_labels]; 
        % sort images w.r.t the score and get the ranking list
        [sorted, img_indexes] = sortrows(aux, 1);
        ranking = sorted(:,2);
        rankings = [rankings,ranking]; 
        % get top5 and bottom5 image indexes
        top5 = [top5; img_indexes(1:5).'];
        bottom5 = [bottom5; img_indexes(end-4:end).'];
    end
    
    
    
end

