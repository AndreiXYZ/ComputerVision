%unflattens an input image (can have 3 color channels or grayscale)
function img = unflatten_image(image)
    num_pixels = prod(size(image));
    if num_pixels==96*96*3
        img = reshape(image, 96, 96, 3);
    else
        if num_pixels==96*96
        img = reshape(image, 96, 96, 1);
        end
    end
end
