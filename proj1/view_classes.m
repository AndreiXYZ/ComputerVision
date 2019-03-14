load('stl10_matlab/train.mat');

[num_train_imgs, dim] = size(X);
completed = zeros(10);

%view a sample picture from each class
for i=1:num_train_imgs
    class_num = y(i,:);
    if completed(class_num) == 1
        continue
    end
    if sum(completed(:))==10
        sum(completed)
        break
    end
    
    completed(class_num) = 1;
    img = X(i,:);
    img = unflatten_image(img);
    
    subplot(1, 10, class_num);
    imshow(img);
    title(class_num);
end