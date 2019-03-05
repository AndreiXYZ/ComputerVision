function v = lucas_kanade(image1, image2)
    % read images and convert them to grayscale
    if size(size(image1)) == 3
        image1 = rgb2gray(image1);
        image2 = rgb2gray(image2);
    end
    image1 = double(image1);
    image2 = double(image2);
    
    % derivatives 
    [I_x, I_y] = gradient(image1);
    I_t = image2 - image1;
    
    % get number of windows
    im_size = size(image1);
    win_size = floor(im_size/15);
    h = win_size(1);
    w = win_size(2);
    v = zeros(h,w,2);
    
    for i = 1: h
        for j = 1 : w
            % derivatives for the window
            window_x = I_x(1 + (i-1)*15: 1 + i*15, 1 + (j-1)*15: 1 + j*15);
            window_y = I_y(1 + (i-1)*15: 1 + i*15, 1 + (j-1)*15: 1 + j*15);
            window_t = I_t(1 + (i-1)*15: 1 + i*15, 1 + (j-1)*15: 1 + j*15);
            
            % computing A, A transpose and b
            A = [window_x(:), window_y(:)];
            b = -window_t(:);
            A_t = transpose(A);
            
            tmp_v = inv(A_t*A)*A_t*b;
            v(i,j,:) = tmp_v;
        end
    end
    v(isnan(v)) = 0;