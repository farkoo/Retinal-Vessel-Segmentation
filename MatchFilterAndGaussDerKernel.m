% MF and FDOG kernel construction
% Inputs:
%       sigma   = scale value
%       YLength = length of neighborhood along y-axis
%       theta   = orientation
%       type    = MF or FDOG
% output:
%       kernel  = Gaussian kernel
function [kernel] = MatchFilterAndGaussDerKernel(sigma, YLength,theta, type)

    if type == 0
        widthOfTheKernel = ceil(sqrt((6*ceil(sigma)+1)^2 + YLength^2));
        if mod(widthOfTheKernel,2) == 0
            widthOfTheKernel = widthOfTheKernel + 1;
        end
        halfLength = (widthOfTheKernel - 1) / 2;
        row = 1;

        for y = halfLength:-1:-halfLength
            col = 1;
            for x = -halfLength:halfLength
                xPrime = x * cos(theta) + y * sin(theta);
                yPrime = y * cos(theta) - x * sin(theta);
                if abs(xPrime) > 3.5*ceil(sigma)
                    matchFilterKernel(row,col) = 0;
                elseif abs(yPrime) > (YLength-1) / 2
                    matchFilterKernel(row,col) = 0;
                else
                    matchFilterKernel(row,col) = -exp(-.5*(xPrime/sigma)^2)/(sqrt(2*pi)*sigma);
                end
                col = col + 1;
            end
            row = row + 1;
        end
        mean=sum(sum(matchFilterKernel))/sum(sum(matchFilterKernel<0));
        for i = 1:widthOfTheKernel
            for j =1:widthOfTheKernel
                if matchFilterKernel(i,j) < 0
                    matchFilterKernel(i,j)=matchFilterKernel(i,j)- mean;
                end
            end
        end
        kernel = matchFilterKernel;
    else
        widthOfTheKernel = ceil(sqrt( (6*ceil(sigma)+1)^2 + YLength^2));
        if mod(widthOfTheKernel,2) == 0
            widthOfTheKernel = widthOfTheKernel + 1;
        end
        halfLength = (widthOfTheKernel - 1) / 2;
        row = 1;
        for y = halfLength:-1:-halfLength
            col = 1;
            for x = -halfLength:halfLength
                xPrime = x * cos(theta) + y * sin(theta);
                yPrime = y * cos(theta) - x * sin(theta);
                if abs(xPrime) > 3.5*ceil(sigma)
                    GaussDerivativeKernel(row,col) = 0;
                elseif abs(yPrime) > (YLength-1) / 2
                    GaussDerivativeKernel(row,col) = 0;
                else
                    GaussDerivativeKernel(row,col)= -exp(-.5*(xPrime/sigma)^2)*xPrime/(sqrt(2*pi)*sigma^3);
                end
                col = col + 1;
            end
            row = row + 1;
        end
        kernel = GaussDerivativeKernel;
    end

end