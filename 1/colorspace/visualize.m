function visualize(input_image)
    %display original image
    subplot(1, 4, 1);
    imshow(input_image);
    %define null channel
    nullChannel = zeros(size(input_image,1), size(input_image,2));
    
    %get all channels
    [ch1, ch2, ch3] = getColorChannels(input_image);
    
    %concat 1st channel with 2 null channels and visualize
    ch1 = cat(3, ch1, nullChannel, nullChannel);
    subplot(1, 4, 2);
    imshow(ch1);
    
    %repeat for other 2 channels
    ch2 = cat(3, nullChannel, ch2, nullChannel);
    subplot(1, 4, 3);
    imshow(ch2);
    
    ch3 = cat(3, nullChannel, nullChannel, ch3);
    subplot(1, 4, 4);
    imshow(ch3);
end