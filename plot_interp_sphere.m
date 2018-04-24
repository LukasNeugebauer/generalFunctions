function [] = plot_interp_sphere(coordinates,values,varargin)
%function [] = plot_interp_sphere(coordinates,values)
%interpolate values for a spherical surface given values for defined
%coordinates.
%
%can also be found as part of my version of the "Subject"-object from
%Selim's fancycarp toolbox
%
%24.04.2018 - Lukas Neugebauer
    
    %fit sphere to data
    [c,r]   = sphereFit(coordinates);

    %make sure it's actually points on a sphere. Minor deviations are okay...
    deviation   = sum(vecnorm(coordinates)-r);
    if deviation >= 0.0001
        error('That''s no sphere tho...');
    end

    %split it up
    [x,y,z]  = deal(coordinates(:,1),coordinates(:,2),coordinates(:,3)); 

    %create a sphere grid and adapt it to fitted sphere
    [xq,yq,zq] = sphere(128);
    xq  = xq.*r + c(1);
    yq  = yq.*r + c(2);
    zq  = zq.*r + c(3);

    %interpolate data
    F   = scatteredInterpolant(x,y,z,values);
    vq  = F(xq,yq,zq);

    %plot fitted data and add points as black dots
    figure;hold on;
    surf(xq,yq,zq,vq);shading interp;
    axis equal;
    plot3(x,y,z,'k.','MarkerSize',25);

    %just in case - is genuine function from MATLAB 2018 onwards.
    function norm = vecnorm(X)
        D = size(X,2);
        %doesn't look nice but it's still nicer than looping through rows. Much
        %faster for big matrices
        funString   = '@(X) sqrt(';
        fun     = [];
        for nd = 1:D
            funString   = [funString,'+X(:,',num2str(D),').^2 ']; %#ok<AGROW>
        end
        funString   = [funString,');'];
        eval(['fun  = ',funString]); %why does everybode hate eval? It's awesome. 
        norm    = feval(fun,X);
    end

end