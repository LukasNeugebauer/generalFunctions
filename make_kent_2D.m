function out    = make_kent_3D(radius,y1,y2,y3,
%function out    = make_kent_2D(center,...
%
%creates a Kent distribution in 3D(which is basically a two-dimensional
%Gaussian on the unit sphere in R³. For further (although admittedly not
%that much) information, have a look here: 
%https://en.wikipedia.org/wiki/Kent_distribution
%
%Alternatively open up a textbook on directional statistics 
%
%Expected parameters:
%   
%   y1      -   Mean direction, highest density of probability function 
%   y2      -   major axis
%   y3      -   minor axis
%   kappa   -   concentration parameter of function
%   beta    -   
%
%