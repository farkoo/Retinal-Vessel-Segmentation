% Retinal vessel extraction by matched filter with first-order derivative of Gaussian
% 
% Inputs: 
%       img = input imgage
%       sigma = scale value 
%       yLength = length of neighborhood along y-axis 
%       numOfDirections = number of orientations
%       mask = image mask 
%       c_value = c value
%       t = threshold value of region props
% Output:
%       vess = vessels extracted
function [vess] = MatchFilterWithGaussDerivative(img, sigma, yLength, numOfDirections, mask, c_value, t)

    if isa(img,'double')~=1 
        img = double(img);
    end
    [rows,cols] = size(img);
    MatchFilterRes(rows,cols,numOfDirections) = 0;
    GaussDerivativeRes(rows,cols,numOfDirections) = 0;

    for i = 0:numOfDirections-1
        matchFilterKernel = MatchFilterAndGaussDerKernel(sigma,yLength, pi/numOfDirections*i, 0);
        gaussDerivativeFilterKernel = MatchFilterAndGaussDerKernel(sigma, yLength, pi/numOfDirections*i, 1);
        MatchFilterRes(:,:,i+1) = conv2(img,matchFilterKernel,'same');
        GaussDerivativeRes(:,:,i+1) = (conv2(img,gaussDerivativeFilterKernel,'same')); 
    end
    maxMatchFilterRes = max(MatchFilterRes,[],3);
    maxGaussDerivativeRes = max(GaussDerivativeRes,[],3);
    D = maxGaussDerivativeRes;
    W = fspecial('average', 31);
    Dm = imfilter(D, W);
    %Normailzation
    Dm = Dm - min(Dm(:));
    Dm = Dm/max(Dm(:));
    %muH = mean value of response image H 
    H = maxMatchFilterRes;
    c = c_value;
    muH = mean(H(:));
    Tc = c * muH;
    T = (1 + Dm) * Tc;
    Mh = (H >= T);
    vess = Mh & mask;
    se = strel('square',3);
    vess = imclose(vess,se);
    vess = bwmorph(vess,'close');
    [L, num] = bwlabel(vess, 8);
    prop = regionprops(L, 'Area');
    idx = find([prop.Area] > t);
    vess = ismember(L,idx);

end
