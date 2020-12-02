function [norm]  = vecnorm(X)
%function [norm]  = vecnorm(X)
%
%X  = matrix, you want magnitude of its rows for
%
%faking vecnorm, which is new from MATLAB 2018a onwards
%basically like norm(vector,2), but for every row of X seperately
%
%
%9-April-2018 - Lukas Neugebauer

    norm = sqrt(sum(X .^ 2, 2));

end
