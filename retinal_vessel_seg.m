function [Se, Sp, Acc, Dice] = retinal_vessel_seg(image,manual)

    im_rgb = im2double(image);
    
    % Create mask base on RGB image vv
    im_mask = im_rgb(:,:,2) > (20/255);
    im_mask = double(imerode(im_mask, strel('disk',3)));
    
    % Extract green channel
    im_green = im_rgb(:,:,2);

    % CLAHE enhancement
    im_enh = adapthisteq(im_green,'numTiles',[8 8],'nBins',128);

    % Replace the black background of the fundus image with the mean of
    % 3 randomly selected (50, 50, 50) background matrices
    [im_enh1, mean_val] = replace_black_ring(im_enh,im_mask);

    % Negative
    im_gray = imcomplement(im_enh1); 

    % Use Top-Hat transform
    se = strel('disk',10);
    im_top = imtophat(im_gray,se);  

    % OTSU Thresholding 
    level = graythresh(im_top);
    im_thre = imbinarize(im_top,level) & im_mask;

    % Delete small connected component
    im_rmpix = bwareaopen(im_thre,100,8);

    % Find thick vessels based on im_gray, im_rmpix and mean_val
    % We can use im_green instead of mean_val but by using mean_val,
    % running time very decrease 
    % [im_sel] = vessel_point_selected(im_gray,im_rmpix,im_green);
    [im_sel] = vessel_point_selected(im_gray,im_rmpix,mean_val);

    % Find thin vessels using MF and FDoG filter 
    im_thin_vess = MatchFilterWithGaussDerivative(im_enh, 1, 4, 12, im_mask, 2.3, 30);

    % Based on im_sel and im_thin_vess, we decide to find the final vessels
    [im_final] = combine_thin_vessel(im_thin_vess,im_sel);

    % Calculate the Acc, Se, Sp and Dice for each image
    [Se, Sp, Acc] = performance_measure(im_final,manual);
    manual = imbinarize(manual);
    Dice = 2*sum(sum((im_final) .* manual))/(sum(sum(im_final))+ sum(sum(manual)));

end

