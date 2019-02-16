function new_image = rgb2opponent(image)
    [r, g, b] = getColorChannels(image);
    o1 = (r-g)./sqrt(2);
    o2 = (r+g-2*b)./sqrt(6);
    o3 = (r+g+b)./sqrt(3);
    new_image = cat(3, o1, o2, o3);
end