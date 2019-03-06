function video = tracking(path, ext,kernel_size, k)
    file_names = dir(fullfile(path, ext));
    images = {};
    for i = 1: length(file_names)
        images{i} = imread(strcat(path,'/',file_names(i).name));
    end
    
    video = {};
    [~, corners] = harris_corner_detector(images{1}, 1e-5);
    close;
    fig = figure;
    for i = 1 : length(file_names) - 1
        % Get velocity
        v = lucas_kanade(images{i}, images{i+1},kernel_size);       
        hold off;
        imshow(images{i});
        
        hold on;
        plot(corners(:,2), corners(:,1), '.r');
        img_size = size(images{i});
        size_v = size(v);
        v(size_v(1)+1, :,:) =  v(size_v(1), :,:);
        v(:, size_v(2)+1,:) =  v(:, size_v(2),:);
        
        % Set velocity arrows at corners coordonates        
        ind_x = int8(1+floor(corners(:,1)./kernel_size));
        ind_y = int8(1+floor(corners(:,2)./kernel_size));
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
        
        % Capture frame
        drawnow
        frame = getframe(fig); 
        img = frame2im(frame); 
        [index,cm] = rgb2ind(img,256); 
        % Write to file
        if i == 1 
            imwrite(index,cm,strcat(path,'.gif'),'gif', 'Loopcount',inf); 
        else 
            imwrite(index,cm,strcat(path,'.gif'),'gif','WriteMode','append'); 
        end 
        
        % Update corners position according to velocity
        for j = 1:length(AUX1)           
            if (corners(j,2) + U(j,j)*k) <= img_size(2) && (corners(j,2) + U(j,j)*k) >=1
                corners(j,2) = corners(j,2) + U(j,j)* k;
            end
            if (corners(j,1) + k*V(j,j)*k) <= img_size(1) && (corners(j,1) + V(j,j)*k) >=1
                corners(j,1) = corners(j,1) + V(j,j)* k;
            end
        end       
        

    end
