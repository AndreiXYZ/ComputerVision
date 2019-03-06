toy = imread('person_toy/00000001.jpg');
treshold = 1e-6;
toy_45 =  imrotate(toy,45);
[H, c2rot] = harris_corner_detector(toy_45, treshold);

toy_90 =  imrotate(toy,90);
%imshow(toy_90);
[H, c3rot] = harris_corner_detector(toy_90, treshold);
