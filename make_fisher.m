function [out] = make_fisher(sph_X,amp,kappa,center)
%function [out] = make_fisher(X,[amp, kappa, alpha, beta])
%get values for Fisher distribution for positions in X. Fisher distribution
%is something like a bivariate Gaussian with constrained covariance matrix
%(i.e., round not oval lines of equal probability)
%
%expected input:
%   
%   sph_X       = n x 2-matrix of spherical coordinates
%       amp     = amplitude - this is no actually a Fisher parameter but
%                 necessary for the present application
%       kappa   = concentration parameter. For 0, the Fisher
%                 distribution becomes a uniform distribution, not sure yet
%                 about the range
%       p(3:4)  = mean direction of the distribution in spherical coordinates
%
%Lukas Neugebauer, 16.05.2018

%the parameters are either rotationally in- or equivariant and thus it
%shouldn't really matter which is which in terms of phi vs. theta and alpha
%vs. beta

%spherical coordinates for which we want the density
phi   = sph_X(:,1);
theta = sph_X(:,2); 

%spherical coordinates of mean direction
alpha = center(1);
beta  = center(2);

%transform spherical to vector for easy computation 
mu    = [cos(alpha),sin(alpha)*cos(beta),sin(alpha)*cos(beta)]';
X     = [cos(phi),sin(phi).*cos(theta),sin(phi).*cos(theta)]';

%the following ommits the normalizing constant. This is not an issue
%because using an amplitude parameter kills the idea of a pdf anyway. It's
%about the ratio of values and that is invariant to  multiplication. The
%constant would be kappa/sinh(kappa), as far as I understood. 
out   = [amp * exp(kappa * mu' * X)]';