img = im2double(imread('ball.png'));
albedo = im2double(imread('ball_albedo.png'));
shading = im2double(imread('ball_shading.png'));

new_img = albedo.*shading;

subplot(2, 2, 1);
imshow(img);
title('Original img.');

subplot(2, 2, 2);
imshow(albedo);
title('Albedo');

subplot(2, 2, 3);
imshow(shading);
title('Shading');

subplot(2, 2, 4);
imshow(new_img);
title('Reconstructed');
