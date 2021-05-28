% Measure the segmentation performance
%   Inputs:
%           final_image = post processed final image
%           target_image = gold standard image
%   Outputs:
%           Se = Sensitivity
%           Sp = Specificity
%           Acc = Accuracy
function [Se, Sp, Acc] = performance_measure(final_image, target_image)


    TP = 0;     % True Positive
    FP = 0;     % False Positive
    FN = 0;     % False Negative
    TN = 0;     % True Negative

    [row, col] = size(target_image);
    target_image = imbinarize(target_image);

    for x = 1:row
        for y = 1:col
            if((final_image(x,y)== 1) && (target_image(x,y) == 1))
                TP = TP + 1;
            elseif((final_image(x,y)== 1) && (target_image(x,y) == 0))
                FP = FP + 1;
            elseif((final_image(x,y)==0)&&(target_image(x,y) ==1))
                FN = FN + 1;
            else
                TN = TN + 1;
            end
        end
    end

    Se = TP /(TP + FN);
    Sp = TN /(TN + FP);
    Acc = (TP + TN)/(TP + FN + TN + FP);

end