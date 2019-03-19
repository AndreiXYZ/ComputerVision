function ap = getAp(y_true, y_predicted, at_index)
    %get average precision for 1 class
    %precision = true_positives/total_positives
    recalls = zeros(1);
    for i=1:at_index
        [c, cm, ind, per] = confusion(y_true(1:i), y_predicted(1:i));
        tp = cm(2,2);
        fp = cm(1,2);
        tn = cm(1,1);
        fn = cm(2,1);
        
        tp+fp
        precision = tp/(tp+fp)
        average_precisions(i) = precision*(y_true(i)==1);
    end
    ap = mean(average_precisions);
    ap
end
