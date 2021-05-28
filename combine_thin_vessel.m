% inputs:
%       im_sel: processing result of thick blood vessel
%       im_thin_vess: thin blood vessel processing result
% output:
%       im_final: final segmentation result
function [im_final] = combine_thin_vessel(im_thin_vess,im_sel)

    [row, col] = size(im_thin_vess);

    kernel = [1, 1, 1;
              1, 0, 1;
              1, 1, 1];    
    im_final = im_thin_vess;

    % Calculate the number of white pixels in the neighborhood
    % of the corresponding 8 position and decide on pixels(vessel or not)
    for i = 2:row - 1
        for j = 2:col - 1
            if(im_sel(i,j) ~= 0 && sum(sum((im_thin_vess(i-1:i+1,j-1:j+1).*kernel)))> 0)
                im_final(i,j) = im_sel(i,j);
            end   
        end
    end

end

