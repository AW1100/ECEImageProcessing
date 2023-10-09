function thres = intermeans_6(im)
    % compute histogram h and transpose
    h = imhist(im)';
    % compute initial threshold
    thres = round(mean2(im));
    thres_prev = thres+1;
    while thres_prev ~= thres
        thres_prev = thres;
        D = 0:thres_prev;
        % calculate mu 1
        meanLow = sum(D.*h(1:thres_prev+1))/sum(h(1:thres_prev+1));
        D = thres_prev+1:255;
        % calculate mu 2
        meanHi = sum(D.*h(thres_prev+2:end))/sum(h(thres_prev+2:end));
        % compute new threshold
        thres = round((meanLow+meanHi)*0.5);
    end
    % normalize the threshold
    thres = thres/255;
end