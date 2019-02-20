img = im2double(imread('ball.png'));
albedo = im2double(imread('ball_albedo.png'));
shading = im2double(imread('ball_shading.png'));

[rows,cols,dim] = size(img);
for i=1:rows
    for j=1:cols
        albedo(i,j,:) = [0,1.0,0];
    end
end

new_img = albedo.*shading;
subplot(1, 2, 1);
imshow(img);
title('Original Image');

subplot(1, 2, 2);
imshow(new_img);
title('Recolored Image');