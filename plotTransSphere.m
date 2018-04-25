function [] = plotTransSphere(varargin)
%function [] = plotTransSphere([r,c,alpha])
%%Plot a transparant sphere with radius r


%handle arguments
if nargin == 0
    r       = 1;
    center  = [0 0 0];
elseif nargin == 1
    r       = varargin{1};
    center  = [0 0 0];
    alpha   = 0.2;
elseif nargin == 2
    r       = varargin{1};
    center  = varargin{2};
    alpha   = 0.2;
elseif nargin == 3
    r       = varargin{1};
    center  = varargin{2};
    alpha   = varargin{3};
end

%prepare data for plotting based on arguments
[x,y,z] = sphere(64);
x = x.*r + center(1);
y = y.*r + center(2);
z = z.*r + center(3);

%make sure to not kill existing plot
if ~ishold
    hold on;
end
   
%plotting
h = surfl(x,y,z);
set(h,'FaceAlpha',alpha);
shading interp;

end