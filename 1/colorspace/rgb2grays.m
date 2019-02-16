function new_image = rgb2grays(image)
    rows = size(image,1);
    cols = size(image, 2);
    [r,g,b] = getColorChannels(image);
    %lightness method
    for i=1:rows
        for j=1:cols
            elems = [r(i,j),g(i,j),b(i,j)];
            %lightness
            lightness(i,j) = (max(elems)+ min(elems))/2;
            %average
            average(i,j) = sum(elems)/3;
            %luminosity
            luminosity(i,j) = 0.21*elems(1)+0.72*elems(2)+0.07*elems(3);
            %matlab's built-in
        end
    end
    builtin = rgb2gray(image);
    
    new_image = lightness;
    
    subplot(2, 2, 1);
    imshow(new_image);
    title('Lightness');
    
    subplot(2, 2, 2);
    imshow(average);
    title('Average');
    
    subplot(2, 2, 3);
    imshow(luminosity);
    title('Luminosity');
    
    subplot(2, 2, 4);
    imshow(builtin);
    title('Matlab builtin');
    
end