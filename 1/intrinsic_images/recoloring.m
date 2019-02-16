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
imshow(new_img);
