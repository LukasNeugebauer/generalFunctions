function [out]    = make_kent_3D(X,center,majAx,kappa,beta,varargin)
%function out    = make_kent_2D(X,y1,y2,y3,kappa,beta[,radius])
%
%creates a variant of a Kent distribution in R³. For further (although 
%admittedly not that much) information, have a look here: 
%https://en.wikipedia.org/wiki/Kent_distribution
%
%The present case is NOT a pdf because multiplying an amplitude to it makes
%it not integrate to 1 anymore.
%
%Source for equations: 
%(Mardia & Jupp, 2000, 'Directional Statistics'); 
%
%
%Expected parameters:
%   
%   X       -   Coordinates for points on a sphere,
%               nx2-matrix of spherical coordinates with radius 1 
%               
%   center  -   Mean direction, highest density of probability function 
%   majAx   -   major axis
%      (minor axis will be inferred as it has to be orthogonal to both the
%      center and the major axis and thus is no free parameter)
%   kappa   -   concentration parameter of function. Higher value means
%               stronger concentration
%   beta    -   ellipsicity parameter. Higher value means more elliptical
%               distribution
%
%
%29-May-2018; Lukas Neugebauer

    %% handle all input parameters and complain if something doesn't look right 
    if size(X,2) == 2
        fprintf('X is assumed to be spherical coordinates and will be transformed to cartesian.\n');
        if isempty(vargin)
            fprintf('Radius is assumed to be 1, if that''t not correct, put in radius as argument.\n');
            radius  = 1;
            center  = [0,0,0];
        else
            radius  = varargin{1};
            center  = [0,0,0];
        end
        [X(:,1),X(:,2),X(:,3)]  = sph2cart(X(:,1),X(:,2),radius);
    elseif size(X,3)
        fprintf('X is assumed to be cartesian coordinates.\n');
        [center,radius]     = sphereFit(X(:,1),X(:,2),X(:,3));
        %sanity check - is everything on a sphere?
        try
            vecMag  = vecnorm(X-center); %distance of all points from center. is a sanity check wether everything is actually on a circle and not just random points. 
        catch
            error('You don''t seem to have the function "vecnorm". It''s built-in from Matlab 2018a onwards, but you can download a replica of it from https://github.com/LukasNeugebauer/generalFunctions.');
        end
        if abs(sum(vecMag - radius)) > 0.001 %leave a little room for error bc spherefit() isn't perfect either
            error('The coordinates don''t seem to be constrained to a spherical surface.\n');
        end
    else
        error('X must be nx2 or nx3-Matrix');
    end

    %y1,y2,y3 need to be row vectors
    if sum(sum([size(y1);size(y2);size(y3)] == [3,1])) ~= 6
        error('y1,y2 and y3 all need to be 3x1 column vectors. That doesn''t seem to be the case.\n');
    end

    %kappa must be bigger than zero
    if kappa <= 0
        error('Kappa must be >0\n');
    end

    %beta must be 0 <= 2beta < kappa
    if beta < 0 || 2*beta >= kappa
        error('Constraint for beta violated: 0 <= 2*beta < kappa.\n');
    end


    %% define function
    %x is a row from X, but will be used as x'
    kentFun     = @(x,y1,y2,y3,kappa,beta) exp(kappa*y1*x' + beta*((y2*x') - (y3*x')));

    %can probably be written in matrix notation but my lin alg sucks, so loop
    %it is
    out     = nan(size(X,1),1);
    out(z)  = feval(kentFun(X(z,:),y1,y2,y3,kappa,beta)); 
    
    %Scale it
    out     = Scale(out);
    
    %Loss function that should be optimized
    
    
    
end