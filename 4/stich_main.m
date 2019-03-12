run('vlfeat-0.9.21/toolbox/vl_setup');
org1 = imread('left.jpg');
org2 = imread('right.jpg');
res = stitch(org1,org2);
imshow(res,[]);