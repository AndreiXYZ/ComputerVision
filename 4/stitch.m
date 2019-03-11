function [panarama] = stitch(img1,img2)
    %Install vlfeat. Only need to run once
    %run('vlfeat-0.9.21/toolbox/vl_setup.m')

    %Read images, convert to grayscale

    image1 = rgb2gray(img1);
    image2 = rgb2gray(img2);

    [kp1, kp2, scores] = keypoint_matching(image1, image2);

    % Find best transformation between images
    [transform, A_best, b_best] = RANSAC(image2, image1, kp2, kp1, 1000, 10);

    % Get the transformed coords of the corners of the second image within a
    % the iamges combined as one
    [rows, cols] = size(image2);
    [rows_1, cols_1] = size(image1);
    corners = [1 1; 1 cols; rows 1; rows cols];
    b_best = [b_best(2); b_best(1)];% i j are inversed here, fixing it
    A_best = [A_best(:,1)';A_best(:,2)'];% fitting the rotation
    for i=1:4
        transformed_corners(i,:) = round(A_best*corners(i,:)'+ b_best);
    end

    % Estimate new image size
    max_cor = max(transformed_corners(:,:)); % getting the rightmost lower corner

    %Plot result

    stitched_image = zeros(max_cor(1),max_cor(2));
    %put the first image into the rows 
    for i = 1:rows_1
        for j = 1:cols_1
            stitched_image(i,j) = image1(i,j);
        end
    end


    %put the second image into the rows 
    for i = 1:rows
        for j = 1:cols
            new_ij = round(A_best*[i j]'+b_best);
            stitched_image(new_ij(1),new_ij(2)) = image2(i,j);
        end
    end

    subplot(2, 2, 1);
    imshow(image1);
    subplot(2, 2, 2);
    imshow(image2);
    subplot(2, 2, [3 4]);
    imshow(stitched_image,[]);
    
    panarama = stitched_image;
end
