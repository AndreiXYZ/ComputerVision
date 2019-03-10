%Install vlfeat. Only need to run once
%run('vlfeat-0.9.21/toolbox/vl_setup')

%Read images, convert to grayscale
image1 = rgb2gray(imread('left.jpg'));
image2 = rgb2gray(imread('right.jpg'));

[kp1, kp2, scores] = keypoint_matching(image1, image2);

% Find best transformation between images
[transform, A_best, b_best] = RANSAC(image2, image1, kp2, kp1, 1000, 10);

% Get the transformed coords of the corners
[rows, cols] = size(image2);
corners = [1 1; 1 cols; rows 1; rows cols]

for i=1:4
    size(corners(i,:))
    size(A_best);
    transformed_corners(i,:) = round(A_best*corners(i,:)'+b_best);
end

transformed_corners

% Estimate new image size
% TODO


%Plot result
%TODO

subplot(1, 2, 1);
imshow(image1);
subplot(1, 2, 2);
imshow(transform);
