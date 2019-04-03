function [maps, mean_map] = getMap(rankings)   
    maps = [];    
    % compute MAP for each class
    for i=1:5
        suma = 0;
        nr_class_images = 0;
        m = sum(rankings(:,i) == 1);
        for j=1:length(rankings)
            if rankings(j,i) == 1
                nr_class_images = nr_class_images+1;
                suma = suma + double(nr_class_images)/j;
            end        
        end
        maps = [maps;double(suma)/m];
    end
    % compute mean MAP over all classes
    mean_map = mean(maps);
end
