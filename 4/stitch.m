run('vlfeat-0.9.21/toolbox/vl_setup')

image1 = rgb2gray(imread('left.jpg'));
image2 = rgb2gray(imread('right.jpg'));

[kp1, kp2, scores] = keypoint_matching(image1, image2);

transform = RANSAC(image2, image1, kp2, kp1, 1000, 10);

subplot(1, 2, 1);
imshow(image1);
size(transform)
size(image2)
subplot(1, 2, 2);
imshow(transform);

% 
% transform = RANSAC(image1, image2, kp1, kp2, 100, 10);
% subplot(1, 2, 1);
% imshow(transform);
% subplot(1, 2, 2);
% imshow(image2);