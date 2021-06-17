close all; clc;
im_rgb = im2double(imread('./DRIVE/Test/images/03_test.tif'));

im_mask = im_rgb(:,:,2) > (20/255); % Extract green channel
im_mask = double(imerode(im_mask, strel('disk',3)));

figure
subplot(2,2,1),imshow(im_rgb),title('general image');
subplot(2,2,2),imshow(im_mask),title('Mask after erosion');

im_green = im_rgb(:,:,2);
subplot(2,2,3),imshow(im_green),title('Green Channel')

% CLAHE
im_enh = adapthisteq(im_green,'numTiles',[8 8],'nBins',128);
subplot(2,2,4),imshow(im_enh),title('CLAHE enhancement')

% replace_black_ring
[im_enh1, mean_val] = replace_black_ring(im_enh,im_mask);

% create negativ of im_enh1
im_gray = imcomplement(im_enh1);  
figure
subplot(2,2,1),imshow(im_gray),title('im_gray')

% top-hat transform
se = strel('disk',10);
im_top = imtophat(im_gray,se);
subplot(2,2,2),imshow(im_top),title('after top-hat')

% OTSU
level = graythresh(im_top);
im_thre = imbinarize(im_top,level) & im_mask;
subplot(2,2,3), imshow(im_thre),title('Otsu threhsolding')

% Remove small pixels
im_rmpix = bwareaopen(im_thre,100,8);
subplot(2,2,4), imshow(im_rmpix),title('Remove small pixels')


[im_sel] = vessel_point_selected(im_gray,im_rmpix,mean_val);
figure
subplot(1,3,1),imshow(im_sel),title('thick vessel extraction')

im_thin_vess = MatchFilterWithGaussDerivative(im_enh, 1, 4, 12, im_mask, 2.3, 30);
subplot(1,3,2), imshow(im_thin_vess),title('thin vessel extraction')

[im_final] = combine_thin_vessel(im_thin_vess,im_sel);
subplot(1,3,3),imshow(im_final),title('final image')

g_truth = imread('./DRIVE/Test/1st_manual/03_manual1.gif');

[Se, Sp, Acc] = performance_measure(im_final,g_truth);

g_truth = imbinarize(g_truth);
dice = 2*sum(sum((im_final) .* g_truth))/(sum(sum(im_final))+ sum(sum(g_truth)));

mixed = zeros(size(im_final, 1), size(im_final, 2), 3);

for i = 1 : size(im_final, 1)
    for j = 1 : size(im_final, 2)
        if im_final(i, j) == g_truth(i, j) && im_final(i, j) == 1
            mixed(i, j, 1) = 0;
            mixed(i, j, 2) = 1;
            mixed(i, j, 3) = 0;
        elseif im_final(i, j) == g_truth(i, j) && im_final(i, j) == 0
            mixed(i, j, 1) = 0;
            mixed(i, j, 2) = 0;
            mixed(i, j, 3) = 0;
        elseif im_final(i, j) ~= g_truth(i, j) && im_final(i, j) == 0
            mixed(i, j, 1) = 1;
            mixed(i, j, 2) = 0;
            mixed(i, j, 3) = 1;
        elseif im_final(i, j) ~= g_truth(i, j) && im_final(i, j) == 1
            mixed(i, j, 1) = 1;
            mixed(i, j, 2) = 0;
            mixed(i, j, 3) = 0;
        end
    end
end
figure, subplot(1,1,1),imshow(mixed, []),title('Mixed')
