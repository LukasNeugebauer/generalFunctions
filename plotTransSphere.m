function [] = plotTransSphere(varargin)
%function [] = plotTransSphere([r,c])
%%Plot a transparant sphere with radius r

%handle arguments
if nargin == 0
    r = 1;
    center = [0 0 0];
elseif nargin == 1
    r = varargin{1};
    center = [0 0 0];
elseif nargin == 2
    r = varargin{1};
    center = varargin{2};
end

%prepare data for plotting based on arguments
[x,y,z] = sphere(64);
x = x.*r + center(1);
y = y.*r + center(2);
z = z.*r + center(3);

%plotting
h = surfl(x,y,z);
set(h,'FaceAlpha',0.5);
shading interp;

end