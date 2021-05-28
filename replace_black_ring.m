% Replace the black background of the fundus image with the mean of
% 3 randomly selected (50, 50, 50) background matrices
%   inputs:
%           im_enh: Contrast enhanced image
%           im_mask: Mask
%   outputs:
%           im_new: Replaced image
%           mean_val: Mean of 3 random region
function [im_new, mean_val] = replace_black_ring(im_enh,im_mask)

    [row, col] = size(im_mask);
    area_sum  = zeros(50,50);     

    posit = ceil((rand(3,2)+1)* 1/3*min(row,col));

    for i = 1:3
        x = posit(i,1);
        y = posit(i,2);
        area_rand= im_enh(x-25:x+24,y-25:y+24); % Select the background
        area_sum = area_sum + area_rand;
    end

    area_sum = area_sum.*1/3;

    mean_val = mean(mean(area_sum));        % Calculate the mean of each dimension
    mean_mask = ~im_mask.*mean_val;         % Generate a new background
    im_new = mean_mask + im_enh.*im_mask;   % Overlay background

end

