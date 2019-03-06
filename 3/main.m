toy = imread('person_toy/00000001.jpg');
pingpong = imread('pingpong/0000.jpeg');

[H, c1] = harris_corner_detector(toy, 1e-6);
[H, c2] = harris_corner_detector(pingpong, 1e-6);

rot_toy = imread('00000001rot.jpg');
[H, c1rot] = harris_corner_detector(rot_toy, 1e-6);
%seems to be rotation invariant for 90 degrees

%% Lucas-Kanade shpere
image1 = imread('sphere1.ppm');
image2 = imread('sphere2.ppm');
kernel_size = 15;
v = lucas_kanade(image1, image2,kernel_size);
im_size = size(v);
imshow(image1);
hold on;
X_axis = [kernel_size/2:kernel_size:im_size(2)*kernel_size];
Y_axis = [kernel_size/2:kernel_size:im_size(1)*kernel_size];
[X_axis, Y_axis] = meshgrid(X_axis,Y_axis);
quiver(X_axis, Y_axis, v(:,:,1),v(:,:,2), 'c');
%% Lucas-Kanade symth
image1 = imread('synth1.pgm');
image2 = imread('synth2.pgm');
kernel_size = 15;
v = lucas_kanade(image1, image2,kernel_size);
im_size = size(v);
imshow(image1);
hold on;
X_axis = [kernel_size/2:kernel_size:im_size(2)*kernel_size];
Y_axis = [kernel_size/2:kernel_size:im_size(1)*kernel_size];
quiver(X_axis, Y_axis, v(:,:,1),v(:,:,2), 'c');
%% Tracking person_toy
vid1 = tracking('person_toy', '*.jpg',35,1.7);

%% Tracking pingpong
vid2 = tracking('pingpong', '*.jpeg',20,2);
