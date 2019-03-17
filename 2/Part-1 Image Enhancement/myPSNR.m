function [ PSNR ] = myPSNR( orig_image, approx_image )
    [m, n] = size(orig_image);
    diff = double(orig_image) - double(approx_image);
    mse = sum(power(diff,2),'all')/ (m * n);    
    rmse = sqrt(mse)
    i_max = max(orig_image,[],'all');
    
    PSNR = 20 * log10(double(i_max) / rmse);  

end
