function [H, corners] = harris_corner_detector(input_image, threshold)
    %get rows and cols of image
    img = rgb2gray(im2double(input_image));
    [num_rows, num_cols] = size(img);
    %create Gx and Gy
    w=9; %size of window
    stddev=2; %stddev of Gaussian
    
    %generate Gaussian filter
    
    
    %for 2d gaussian
    G = fspecial('gaussian', w, stddev);
    %get its derivatives along both axis
    [Gx Gy] = gradient(G);
    
    %convolve around x axis using Gaussian derivative
    i_x = conv2(img, Gx, 'same');
    %convolve around y axis using Gaussian derivative
    i_y = conv2(img, Gy, 'same');

    %plot of directional derivatives
    figure;
    subplot(1, 3, 1);
    imshow(i_x, []);
    title('Derivative along x-axis');
    subplot(1, 3, 2);
    imshow(i_y, []);
    title('Derivative along y-axis');
    
    %2nd order derivatives
    ix2 = conv2(i_x.^2, G, 'same');
    ixy = conv2(i_x.*i_y, G, 'same');
    iy2 = conv2(i_y.^2, G, 'same');
    
    %compute moving sum using sliding window (equivalent with convolving
    %with filter of ones)
    A = conv2(ix2, ones(3,3));
    B = conv2(ixy, ones(3,3));
    C = conv2(iy2, ones(3,3));
    
    k = 0.04;
    
    
    %create Harris matrix
    H = zeros(1,1);
    corners = ones(1,2);
    
    for i=1:num_rows
        for j=1:num_cols
            %create Q
            Q = [A(i,j) B(i,j); B(i,j) C(i,j)];
            %compute the entry in the H matrix
            lambda1 = Q(1,1);
            lambda2 = Q(2,2);
            H(i,j) = lambda1*lambda2-k*((lambda1+lambda2)^2);
        end
    end

    %compute corners matrix
    isRegionalMax = imregionalmax(H, 8);
    for i=1:num_rows
        for j=1:num_cols
            if isRegionalMax(i,j) == 1 && H(i,j) > threshold
                corners(end+1,:) = [i, j];
             end
         end
    end
    
    %plot resulting image + detected corners
    subplot(1, 3, 3);
    imshow(input_image);
    hold on;
    plot(corners(:,2), corners(:,1), 'o');
    title('Detected Corner Points');
    