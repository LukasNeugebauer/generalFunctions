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

    D = size(X,2);

    %doesn't look nice but it's still nicer than looping through rows. Much
    %faster for big matrices
    
    funString   = '@(X) sqrt(';
    for x = 1:D
        funString   = [funString,'+X(:,',num2str(x),').^2 ']; %#ok<AGROW>
    end
    funString   = [funString,');'];
    
    eval(['fun  = ',funString]); %why does everybode hate eval? It's awesome. 
    norm    = feval(fun,X);

end