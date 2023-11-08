function im2 = myequalize_06(im)
% Assignment 3 histogram equalize algorithm
%
    % Get input histogram
    [H, D] = imhist(im);
    [rows,cols] = size(im);
    dmax = max(D);
    a0 = rows*cols;
    % Dm/A0
    cons = dmax/a0;
    im2 = uint8(zeros(rows,cols));
    for i=1:rows
        for j=1:cols
            % Summation of HA(i) from 0 to DA
            da = im(i,j);
            im2(i,j) = uint8(round(cons*double(sum(H(1:da+1)))));
        end
    end
end