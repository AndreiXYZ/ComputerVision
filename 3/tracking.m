function video = tracking(path, ext)
    file_names = dir(fullfile(path, ext));
    images = {};
    for i = 1: length(file_names)
        images{i} = imread(strcat(path,'/',file_names(i).name));
    end
    
    video = {};
    
    for i = 1 : 1%length(file_names) - 1
        [~, corners] = harris_corner_detector(images{i}, 1e-6);
        v = lucas_kanade(images{i}, images{i+1});
        %im_size = size(v);
        hold off;
        imshow(images{i});
        hold on;
        size_v = size(v);
        v(size_v(1)+1, :,:) =  v(size_v(1), :,:);
        v(:, size_v(2)+1,:) =  v(:, size_v(2),:);
        
        ind_x = int8(1+floor(corners(:,1)./15));
        ind_y = int8(1+floor(corners(:,2)./15));
        ind_z = ones(length(corners(:,1)),1);
        
        indices_1 = sub2ind(size(v), ind_x,ind_y,ind_z);
        indices_2 = sub2ind(size(v), ind_x,ind_y,2*ind_z);
        
        
        AUX1 = v(indices_1);
        AUX2 = v(indices_2);
        X = eye(length(corners(:,2))).* corners(:,2);
        Y = eye(length(corners(:,1))).* corners(:,1);
        U = eye(length(AUX1)).* AUX1;
        V = eye(length(AUX2)).* AUX2;
 
        quiver(X, Y, U, V, 3);
        

    end