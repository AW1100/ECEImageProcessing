function y = countGL_6(im,v)
%y = countGL_6 where im is an image type of uint8, v is a vector of 
%strictly increasing numbers with length N. y is a vector with
%length N-1. y(i) is the total number of pixels that satisfy the
%condition im>=v(i) and im<v(i+1)
    if(length(v)<2)
        error('The size of vector v must be greater than 1.')
    end
    N = length(v);
    y = zeros(1,N-1);
    for i = 1:N-1
        for e = 1:numel(im)
            if im(e) >= v(i) && im(e) < v(i+1)
                y(i) = y(i) + 1;
            end
        end
    end
end