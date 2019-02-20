close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = './MonkeyColor/';   % TODO: get the path of the script
%image_ext = '*.png';

[image_stack, ~] = load_syn_images(image_dir);
[h, w, ~] = size(image_stack);

if contains(image_dir, 'Color') == 0
    loop = 1;
    albedo = zeros([h, w, 1]);
    normals = zeros([h, w, 3, 1]);
    SE = zeros([h, w, 1]);
    p = zeros([h, w, 1]);
    q = zeros([h, w, 1]);
    height_map = zeros([h, w, 1]);
else
    loop = 3;
    albedo = zeros([h, w, 3]);
    normals = zeros([h, w, 3, 3]);
    SE = zeros([h, w, 3]);
    p = zeros([h, w, 3]);
    q = zeros([h, w, 3]);
    height_map = zeros([h, w, 3]);
end
for iter = 1 : loop
    [image_stack, scriptV] = load_syn_images(image_dir, iter);
    [h, w, n] = size(image_stack);
    fprintf('Finish loading %d images.\n\n', n);
    % compute the surface gradient from the stack of imgs and light source mat
    disp('Computing surface albedo and normal map...')
    [albedo(:,:,iter), normals(:,:,:,iter)] = estimate_alb_nrm(image_stack, scriptV,true);

    %[u,v,w] = surfnorm(normals(:,:,1),normals(:,:,2),normals(:,:,3));
    %quiver3(normals(:,:,1),normals(:,:,2),normals(:,:,3),u,v,w,0.7)

end
normals(isnan(normals)) = 0;
albedo(isnan(albedo)) = 0;

%% 
[u,v,w] = surfnorm(mean(normals(:,:,1,:), 4), mean(normals(:,:,2,:), 4),mean(normals(:,:,3,:),4));
quiver3(mean(normals(:,:,1,:), 4), mean(normals(:,:,2,:), 4),mean(normals(:,:,3,:),4),u,v,w,0.7)
%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
normals(isnan(normals)) = 0;
albedo(isnan(albedo)) = 0;

threshold = 0.005;
for iter = 1 : loop
    disp('Integrability checking')
    [p(:,:,iter), q(:,:,iter), SE(:,:,iter)] = check_integrability(normals(:,:,:,iter));

    SE(SE(:,:,iter) <= threshold) = NaN; % for good visualization
    fprintf('Number of outliers: %d\n\n', sum(sum(SE(:,:,iter) > threshold)));

    %imshow(SE(:,:,iter));
end
SE(isnan(SE)) = 0;

%% compute the surface height
for iter = 1 : loop
    height_map(:,:, iter) = construct_surface( p(:,:,iter), q(:,:,iter),'average' );
end
%height_map(isnan(height_map)) = 0;
%% Display
show_results(albedo, mean(normals, 4), sum(SE, 3));
show_model(albedo, mean(height_map,3));


%% Face
[image_stack, scriptV] = load_face_images('./yaleB02/all_imgs/');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV,false);
normals(isnan(normals)) = 0;
albedo(isnan(albedo)) = 0;
%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q, 'average' );
show_results(albedo, normals, SE);
show_model(albedo, height_map);

%%
imshow(image_stack(:,:,1))
for i=2:n
    figure, imshow(image_stack(:,:,i))    
end
