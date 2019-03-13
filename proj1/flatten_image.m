%return flattened image
function img = flatten_image(image)
    num_pixels = prod(size(image));
    img = reshape(image, 1, num_pixels);
end