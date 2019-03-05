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
v = lucas_kanade(image1, image2);
im_size = size(v);
imshow(image1);
hold on;
X_axis = [8:15:im_size(2)*15];
Y_axis = [8:15:im_size(1)*15];
[X_axis, Y_axis] = meshgrid(X_axis,Y_axis);
quiver(X_axis, Y_axis, v(:,:,1),v(:,:,2), 'c');
%% Lucas-Kanade symth
image1 = imread('synth1.pgm');
image2 = imread('synth2.pgm');

v = lucas_kanade(image1, image2);
im_size = size(v);
imshow(image1);
hold on;
X_axis = [8:15:im_size(2)*15];
Y_axis = [8:15:im_size(1)*15];
quiver(X_axis, Y_axis, v(:,:,1),v(:,:,2), 'c');
%% Tracking
vid = tracking('pingpong', '*.jpeg');
%%
img1 = imread('pingpong/0000.jpeg');
img2 = imread('pingpong/0001.jpeg');

[~, corners] = harris_corner_detector(img1, 1e-6);
v = lucas_kanade(img1, img2);

%%
hold off;
       imshow(img1);
        hold on;
        size_v = size(v);
        v(size_v(1)+1, :,:) =  v(size_v(1), :,:);
        v(:, size_v(2)+1,:) =  v(:, size_v(2),:);
        ind_x = int8(1+floor(corners(:,1)./15));
        ind_y = int8(1+floor(corners(:,2)./15));
        ind_z = ones(length(corners(:,1)),1);
        
        indices_1 = sub2ind(size(v), ind_x,ind_y,ind_z);
        indices_2 = sub2ind(size(v), ind_x,ind_y,2*ind_z);
        
        
        AUX1 = v(indices_1);
        AUX2 = v(indices_2);
        X = eye(length(corners(:,2))).* corners(:,2);
        Y = eye(length(corners(:,1))).* corners(:,1);
        U = eye(length(AUX1)).* AUX1;
        V = eye(length(AUX2)).* AUX2;
        
        q = quiver(X, Y, U, V,3);
 