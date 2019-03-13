%converts an input image to normed rgb
function new_image = rgb2normedrgb(image)
    [r,g,b] = getColorChannels(image);
    sumAll = r+g+b;
    r = r./sumAll;
    g = g./sumAll;
    b = b./sumAll;
    new_image = cat(3, r, b, b);
end