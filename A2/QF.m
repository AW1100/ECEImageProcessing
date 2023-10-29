close all;
bw=imread('riceBW.tif');
cc = bwconncomp(bw);
disp(cc.NumObjects);

SE=strel('disk',1);
bw1=imopen(bw,SE);
cc1 = bwconncomp(bw1);
disp("imopen: " + cc1.NumObjects);

bw2 = bwareaopen(bw,5);
cc2 = bwconncomp(bw2);
disp("bwareaopen: " + cc2.NumObjects);

rows = 1;
columns = 4;

subplot(rows, columns, 1);
imshow(imread('rice.png'));
title('grayscale');

% Display the first image in the first subplot
subplot(rows, columns, 2);
imshow(bw);
title('intermeans');

% Display the second image in the second subplot
subplot(rows, columns, 3);
imshow(bw1);
str1 = "imopen: " + cc1.NumObjects;
title(str1);

% Display the third image in the third subplot
subplot(rows, columns, 4);
imshow(bw2);
str2 = "bwareaopen: " + cc2.NumObjects;
title(str2);