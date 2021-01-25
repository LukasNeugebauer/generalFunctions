function [X] = normit(Y)
%function [X] = normit(Y)
%
% Shift and scale columns so that their mean is 0 and SD is 1

    SD = std(Y, 1);
    mu = mean(Y, 1);
    X  = (Y - mu) ./ SD;

end
