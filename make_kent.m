function [out]    = make_kent(X,mu,majAx,minAx,kappa,beta,amp)
%function out    = make_kent_2D(X,y1,y2,y3,kappa,beta[,radius])
%
%creates a variant of a Kent distribution in R³. For further (although 
%admittedly not that much) information, have a look here: 
%https://en.wikipedia.org/wiki/Kent_distribution
%
%The present case is NOT a pdf because multiplying an amplitude to it makes
%it not integrate to 1 anymore.
%
%Relevant annotation: This functions uses vectors of cartesian coordinates
%instead of spherical coordinates in order to impose constraints on the
%orthogonality of several input arguments for the optimizing algorithm more 
%conveniently. 
%
%Source for equations: 
%(Mardia & Jupp, 2000, 'Directional Statistics'); 
%
%
%Expected parameters:
%   
%   X       -   Coordinates for points on a sphere,
%               nx2- or nx3-matrix of spherical coordinates with radius 1 
%               Will be converted to cartesian if spherical               
%
%   mu      -   Mean direction, highest density of probability function 
%   majAx   -   major axis
%   minAx   -   minor axis
%      (minor axis can actually be inferred as it has to be orthogonal to 
%       both the center and the major axis and thus is no free parameter.
%       It's still necessary in here for constraints)
%   kappa   -   concentration parameter of function. Higher value means
%               stronger concentration
%   beta    -   ellipsicity parameter. Higher value means more elliptical
%               distribution
%   amp     -   amplitude of the distribution. Only possible because we
%               don't use an actual PDF
% 
%
%04-June-2018; Lukas Neugebauer

    %% handle all input parameters and complain if something doesn't look right 
    if size(X,2) == 2
        %fprintf('X is assumed to be spherical coordinates and will be transformed to cartesian.\nRadius is assumed to be 1.\n');
        radius =    1;
        [X(:,1),X(:,2),X(:,3)]  = sph2cart(X(:,1),X(:,2),radius);
    elseif size(X,3)
%         fprintf('X is assumed to be cartesian coordinates.\n');
        [mu,radius]     = sphereFit(X(:,1),X(:,2),X(:,3));
        %sanity check - is everything on a sphere?
        vecMag  = vecnorm(X-mu); %distance of all points from center. is a sanity check wether everything is actually on a circle and not just random points. 
        if abs(sum(vecMag - radius)) > 0.001 %leave a little room for error bc spherefit() isn't perfect either
            error('The coordinates don''t seem to be constrained to a spherical surface.\n');
        end
    else
        error('X must be nx2 or nx3-Matrix');
    end

    %note that kappa and beta are subject to several constraints but will
    %be constrained within the optimizer, not here. This allows for
    %incorrect results and assumptions when using this function from
    %somewhere else than a optimizing algorithm that imposes these
    %constraints upon the parameters. Be aware of that and act accordingly.

    %% define function
    %x is a row from X, but will be used as x'
    kentFun     = @(X1,X2,X3,mu,kappa,beta) exp( kappa * X1 + beta * (X2.^2 - X3.^2));

    %unnecesary step that makes reading of formula input easier. make
    %everything a row vector, such that transposing it denotes a column
    %vector in all cases.
    mu      = asColumn(mu);
    majAx   = asColumn(majAx);
    minAx   = asColumn(minAx);
    
    X       = X'; %now column vectors are the points
    
    %prepare all the parameters. Again - not really necessary but makes
    %everything more readable and uses the nomenclature of Mardia & Jupp
    %(2000);
    X1  = mu' * X;
    X2  = majAx' * X;
    X3  = minAx' * X;
            
    %linear algebra makes use of loops unnecessary.
    out     = kentFun(X1,X2,X3,mu,kappa,beta); 
    out     = out' * amp;
        
end