toy = imread('person_toy/00000001.jpg');
pingpong = imread('pingpong/0000.jpeg');

[H, c1] = harris_corner_detector(toy, 1e-6);
[H, c2] = harris_corner_detector(pingpong, 1e-6);

rot_toy = imread('00000001rot.jpg');
[H, c1rot] = harris_corner_detector(rot_toy, 1e-6);
%seems to be rotation invariant for 90 degrees


