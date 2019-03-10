%% Keypoint Matching
run('vlfeat-0.9.21/toolbox/vl_setup')

image1 = imread('boat1.pgm');
image2 = imread('boat2.pgm');
[keypoints1, keypoints2, scores] = keypoint_matching(image1, image2);

%% Plot 10 random matching keypoints
plot_matching_points(image1,image2,keypoints1,keypoints2);

%% RANSAC image1 -> image2
[transform, A_best, b_best] = RANSAC(image1,image2, keypoints1, keypoints2, 100, 300);
pair = [transform,image2];
imshow(pair)

%% RANSAC image2 -> image1
[transform, A_best, b_best] = RANSAC(image2,image1, keypoints2, keypoints1, 200, 500);
pair = [transform,image1];
imshow(pair)