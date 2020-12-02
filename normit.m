function [X] = normit(Y)
%function [X] = normit(Y)
%
% Scales columns so that their SD is 1 each
% Doesn't shift anything, mean doesn't change

    SD = std(Y, 1);
    mu = mean(Y, 1);
    X  = (Y - mu) ./ SD;
    
end
    