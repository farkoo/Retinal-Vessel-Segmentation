function dataset_test(file_path_im,file_path_manual,im_postfix,ma_postfix)

    img_path_list_im = dir(strcat(file_path_im,im_postfix)); 
    img_path_list_manual = dir(strcat(file_path_manual,ma_postfix)); 
    img_num = length(img_path_list_im); 
    excel = zeros(21,4);
    sum_Acc = 0;
    sum_Se = 0;
    sum_Sp = 0;
    sum_Dice = 0;
    if img_num > 0
        for i = 1:img_num
            image_name = img_path_list_im(i).name;      
            manual_name = img_path_list_manual(i).name; 
            image =  imread(strcat(file_path_im,image_name));
            manual =  imread(strcat(file_path_manual,manual_name));
            [Se, Sp, Acc, Dice] = retinal_vessel_seg(image,manual);
            excel(i, 1) = Acc;
            excel(i, 2) = Se;
            excel(i, 3) = Sp;
            excel(i, 4) = Dice;

            sum_Acc = sum_Acc + excel(i, 1);
            sum_Se = sum_Se + excel(i, 2);
            sum_Sp = sum_Sp + excel(i, 3);
            sum_Dice = sum_Dice + excel(i, 4);
        end

        excel(21,1) = sum_Acc/20;
        excel(21,2) = sum_Se/20;
        excel(21,3) = sum_Sp/20;
        excel(21,4) = sum_Dice/20;
        xlswrite('Performance.csv', excel);

    end

end

