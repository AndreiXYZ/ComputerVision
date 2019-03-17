function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)

% the kernel to compute the convolution with
kernel = [1, 0, -1; 2, 0 , -2; 1, 0, -1];  
Gx = imfilter(double(image), kernel,'conv');
Gy = imfilter(double(image), kernel','conv');

thresh = 200;
% binarizing the Gx
Gx(abs(Gx) < thresh) = 0;
Gx(abs(Gx) >= thresh) = 1;

% binarizing the Gy
Gy(abs(Gy) < thresh) = 0;
Gy(abs(Gy) >= thresh) = 1;

im_magnitude = sqrt(Gx .* Gx + Gy .* Gy);
im_direction = atan2(Gy , Gx);
end

