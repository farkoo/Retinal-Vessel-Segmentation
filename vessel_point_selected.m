%   inputs:
%           im_gray: grayscale image
%           im_thre: threshold processing image
%           mean_val: background mean (or geen channel of RGB image)
%   output:
%           im_sel: optimized image
function [im_sel] = vessel_point_selected(im_gray,im_thre,mean_val)

    [row, col] = size(im_gray);
    im_sel = zeros(row, col);

    p_max = max(max(im_gray));
    p_min = mean_val;

    for i = 1:row
        for j = 1:col
            if(im_thre(i,j) ~= 0)
                if(abs(im_gray(i,j)-p_max) < abs(im_gray(i,j)-p_min))
                    % vessel pixel
                    im_sel(i,j) = 1;
                end            
            end   
        end
    end

    im_med = medfilt2(im_thre,[3,3]); 
    im_sel = im_sel| im_med;

end

