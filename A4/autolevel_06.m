function [im2, a] = autolevel_06(fname)
M = 10; 
N = 10;
im = imread( fname );

figure;
subplot(1,3,1);
imshow(im);
title('Original');

subplot(1,3,2);
imshow(im);
title('Auto selected points');
impixelinfo;

[width,height] = size(im);
block_rows = floor(width/M);
block_cols = floor(height/N);

x=[];
y=[];
I = [];

% iterate through each block
for i=1:block_rows
    for j=1:block_cols
        m = im((i-1)*M+1:i*M,(j-1)*N+1:j*N);
        min_value = min(min(m)); % minimun value in current block
        [y_t,x_t] = find(m == min_value); % get all points with min value
        y_t = M*(i-1)+y_t; % convert to entire image coordinates
        x_t = N*(j-1)+x_t;
        I_t = double(min_value)*ones(size(y_t,1),1);
        x = vertcat(x,x_t);
        y = vertcat(y,y_t);
        I = vertcat(I,I_t);
    end
end

hold on; plot(x, y, 'y+'); hold off
% Fit data at selected points to background function
%  Solve least-squares problem: [C]{a} = {k} using the
%    \ operator, i.e., {a} = [C]\{k}
%  First, compute elements of the matrix [C]
N = length(x);
Sx = sum(x);
Sy = sum(y);
Sxx = sum(x.*x);
Syy = sum(y.*y);
Sxy = sum(x.*y);
Sxxx = sum(x.^3);
Sxxy = sum(x.*x.*y);
Sxyy = sum(x.*y.*y);
Syyy = sum(y.^3);
Sxxxx = sum(x.^4);
Sxxxy = sum(y.*x.^3);
Sxxyy = sum(x.*x.*y.*y);
Sxyyy = sum(x.*y.^3);
Syyyy = sum(y.^4);
C = [N    Sx  Sy   Sxx   Syy   Sxy;
    Sx   Sxx Sxy  Sxxx  Sxyy  Sxxy;
    Sy   Sxy Syy  Sxxy  Syyy  Sxyy;
    Sxx Sxxx Sxxy Sxxxx Sxxyy Sxxxy;
    Syy Sxyy Syyy Sxxyy Syyyy Sxyyy;
    Sxy Sxxy Sxyy Sxxxy Sxyyy Sxxyy];
% Construct {k} 
SI = sum(I);
SxI = sum(x.*I);
SyI = sum(y.*I);
SxxI = sum(x.*x.*I);
SyyI = sum(y.*y.*I);
SxyI = sum(x.*y.*I);
k = [SI SxI SyI SxxI SyyI SxyI]';
% Solve
a = C\k;

% Remove background
% First compute background image
[rows, cols] = size(im);
[x, y] = meshgrid( 1:cols, 1:rows );
back = a(1) + a(2)*x + a(3)*y + a(4)*x.*x + a(5)*y.*y +a(6)*x.*y;
im2 = double(im) - back;
im2 = mat2gray(im2); % Convert matrix of type double to image of type double
im2 = im2uint8(im2); % Convert to uint8 image. Although you were not asked
                     % to do this, it is useful to make output same type as
                     % input image.

subplot(1,3,3);
imshow(im2);
title('Leveled');
end