function [result] = AWB(filename)

original = imread(filename);
linear_rgb = rgb2lin(original);
illuminant = illumgray(linear_rgb);
corrected_linear = chromadapt(linear_rgb,illuminant,'ColorSpace','linear-rgb');
corrected = lin2rgb(corrected_linear);

pair = [original, corrected]; 
imshow(pair);

result = corrected;
end