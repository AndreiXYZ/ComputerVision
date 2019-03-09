function transform = RANSAC(image1,image2, keypoints1, keypoints2, n, p)
    x_best = [];
    max_inliners_count = 0;
    
    % Repeat N times
    for i=1:n
        % Pick P random matching pairs
        perm = randperm(size(keypoints1,2)) ;
        sel = perm(1:p) ;
        selected_keypoints1 = keypoints1(:,sel);
        selected_keypoints2 = keypoints2(:,sel);
        
        % Create A and b
        A = [];
        b = [];
        for j=1:p
            A_keypoint = [selected_keypoints1(1,j), selected_keypoints1(2,j), 0, 0, 1, 0;...
                0, 0, selected_keypoints1(1,j), selected_keypoints1(2,j), 0, 1];
            
            b_keypoint = [selected_keypoints2(1,j); selected_keypoints2(2,j)];
            
            A = [A;A_keypoint];
            b = [b;b_keypoint];
        
        end
        
        % Compute transformation parameters
        x = pinv(A)*b;        
        A_transform = [x(1), x(2); x(3), x(4)];
        b_transform = [x(5); x(6)];
        
        % Transform the keypoints and calculate nr. of inliners 
        transformed_keypoints = keypoints1;
        inliners_count = 0;
        for j = 1:length(keypoints1)      
            transformed_keypoints(:,j) = round(A_transform*keypoints1(:,j) + b_transform);     
            if abs(transformed_keypoints(1,j) - keypoints2(1,j))<=10 && abs(transformed_keypoints(2,j) - keypoints2(2,j))<=10 
                inliners_count = inliners_count + 1;             
            end
        end
        
        %figure,plot_matching_points(image1,image2,transformed_keypoints,keypoints1);
        
        % Update the best transformation parameters
        if inliners_count > max_inliners_count
            max_inliners_count = inliners_count;
            x_best = x;
        end       
        
    end
    
    % Transform image
    size_img = size(image1);
    transform = zeros(size_img,'uint8');
    A_best_transform = [x_best(1), x_best(2); x_best(3), x_best(4)];
    b_best_transform = [x_best(5); x_best(6)];
    for i=1:size_img(1)
        for j = 1:size_img(2)           
            new_coords = A_best_transform*[j;i] + b_best_transform;
            round_coords = round(new_coords);
            floor_coords = floor(new_coords);
            ceil_coords = ceil(new_coords);
         
            if floor_coords(1)>0 && ceil_coords(1)<=size_img(2) && floor_coords(2)>0 && ceil_coords(2)<=size_img(1)
                transform(round_coords(2),round_coords(1)) = image1(i,j);
                
                % Fill also the neighbor pixels if they are 0 because some coordonates
                % are never computed from transformation and we assign one
                % of the neighborhood calues for those pixels in order not
                % to be black pixels
                if transform(round_coords(2),ceil_coords(1) + floor_coords(1) - round_coords(1)) == 0
                     transform(round_coords(2),ceil_coords(1) + floor_coords(1) - round_coords(1)) = image1(i,j);
                    
                end
                if transform(ceil_coords(2) + floor_coords(2) - round_coords(2),round_coords(1)) == 0
                     transform(ceil_coords(2) + floor_coords(2) - round_coords(2),round_coords(1)) = image1(i,j);
              
                end              
                if transform(ceil_coords(2) + floor_coords(2) - round_coords(2),ceil_coords(1) + floor_coords(1) - round_coords(1)) == 0
                    transform(ceil_coords(2) + floor_coords(2) - round_coords(2),ceil_coords(1) + floor_coords(1) - round_coords(1)) = image1(i,j);
                end
            end
        end        
    end
    
end

