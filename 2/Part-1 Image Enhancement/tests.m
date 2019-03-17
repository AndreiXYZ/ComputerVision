%% Test myPSNR

img1_salt_and_pepper = imread('images/image1_saltpepper.jpg');
img1_gaussian = imread('images/image1_gaussian.jpg');
img1 = imread('images/image1.jpg');

psnr_1 = myPSNR(img1,img1_salt_and_pepper);
psnr_2 = myPSNR(img1,img1_gaussian);

%% Test Denoise Box Filter

img1_salt_and_pepper = imread('images/image1_saltpepper.jpg');
img1_gaussian = imread('images/image1_gaussian.jpg');

snp_box_filter_3x3 = denoise(img1_salt_and_pepper,'box',3);
snp_box_filter_5x5 = denoise(img1_salt_and_pepper,'box',5);
snp_box_filter_7x7 = denoise(img1_salt_and_pepper,'box',7);

gauss_box_filter_3x3 = denoise(img1_gaussian,'box',3);
gauss_box_filter_5x5 = denoise(img1_gaussian,'box',5);
gauss_box_filter_7x7 = denoise(img1_gaussian,'box',7);

%% Test Denoise Median Filter

snp_median_filter_3x3 = denoise(img1_salt_and_pepper,'median',3,3);
snp_median_filter_5x5 = denoise(img1_salt_and_pepper,'median',5,5);
snp_median_filter_7x7 = denoise(img1_salt_and_pepper,'median',7,7);

gauss_median_filter_3x3 = denoise(img1_gaussian,'median',3,3);
gauss_median_filter_5x5 = denoise(img1_gaussian,'median',5,5);
gauss_median_filter_7x7 = denoise(img1_gaussian,'median',7,7);

%% Plot Denoise Results SNP Box

imshow(snp_box_filter_3x3);
figure,imshow(snp_box_filter_5x5);
figure,imshow(snp_box_filter_7x7);
%% Plot Denoise Results Gauss Box

imshow(gauss_box_filter_3x3);
figure,imshow(gauss_box_filter_5x5);
figure,imshow(gauss_box_filter_7x7);

%% Plot Denoise Results SNP Median

imshow(snp_median_filter_3x3);
figure,imshow(snp_median_filter_5x5);
figure,imshow(snp_median_filter_7x7);

%% Plot Denoise Results Gauss Median

imshow(gauss_median_filter_3x3);
figure,imshow(gauss_median_filter_5x5);
figure,imshow(gauss_median_filter_7x7);

%% PSNR of denoise results

psnr_snp_box_3 = myPSNR(img1,snp_box_filter_3x3);
psnr_snp_box_5 = myPSNR(img1,snp_box_filter_5x5);
psnr_snp_box_7 = myPSNR(img1,snp_box_filter_7x7);

psnr_gauss_box_3 = myPSNR(img1,gauss_box_filter_3x3);
psnr_gauss_box_5 = myPSNR(img1,gauss_box_filter_5x5);
psnr_gauss_box_7 = myPSNR(img1,gauss_box_filter_7x7);

psnr_snp_median_3 = myPSNR(img1,snp_median_filter_3x3);
psnr_snp_median_5 = myPSNR(img1,snp_median_filter_5x5);
psnr_snp_median_7 = myPSNR(img1,snp_median_filter_7x7);

psnr_gauss_median_3 = myPSNR(img1,gauss_median_filter_3x3);
psnr_gauss_median_5 = myPSNR(img1,gauss_median_filter_5x5);
psnr_gauss_median_7 = myPSNR(img1,gauss_median_filter_7x7);

%% Denoise with Gaussian filter

gauss_filter_3_sigma_1 = imgaussfilt(img1_gaussian,0.7,'FilterSize',3);
gauss_filter_5_sigma_1 = imgaussfilt(img1_gaussian,0.85,'FilterSize',5);
gauss_filter_7_sigma_1 = imgaussfilt(img1_gaussian,0.85,'FilterSize',7);

gauss_filter_3_sigma_3 = denoise(img1_gaussian,'gaussian',0.2,[3,3]);
gauss_filter_5_sigma_3 = denoise(img1_gaussian,'gaussian',0.5,[3,3]);
gauss_filter_7_sigma_3 = denoise(img1_gaussian,'gaussian',5,[3,3]);



%% Plot Gaussian filter results

imshow(gauss_filter_3_sigma_1);
figure, imshow(gauss_filter_5_sigma_1);
figure, imshow(gauss_filter_7_sigma_1);
%%
imshow(gauss_filter_3_sigma_3);
figure, imshow(gauss_filter_5_sigma_3);
figure, imshow(gauss_filter_7_sigma_3);

%% PSNR Gaussian filter
psnr_gauss_3 = myPSNR(img1,gauss_filter_3_sigma_3);
psnr_gauss_5 = myPSNR(img1,gauss_filter_5_sigma_3);
psnr_gauss_7 = myPSNR(img1,gauss_filter_7_sigma_3);

%% Gradient computation
img2 = imread('images/image2.jpg');
[Gx, Gy, im_mag, im_dir] = compute_gradient(img2);
% Gx
figure('name','Gx')
imshow(Gx);
hold off
% Gy
figure('name','Gy')
imshow(Gy);
hold off
% Magnitude
figure('name','Magnitude')
imshow(im_mag);
hold off
% Direction
figure('name','Direction')
imshow(im_dir);
%% Second order Derivatives
img2 = imread('images/image2.jpg');
method1 = compute_LoG(img2, 1);
figure('name','Method 1')
imshow(method1);
hold off
figure('name','Method 2')
method2 = compute_LoG(img2, 2);
imshow(method2);
hold off
figure('name','Method 3')
method3 = compute_LoG(img2, 3);
imshow(method3);

