function [h]    = big_figure(varargin);
%[h]    = big_figure([padding][,monitor]);
%
%Tired of opening wrong-sized figures in MATLAB? Me too... Fear no more!
%will open a new figure and return handle. Optional arguments:
%
%padding    - default = 0 = complete screen. Positive integers reduce size
%             by this many pixels but keep it centered, i.e. it steals half 
%             this many pixels per side
%
%monitor    - on which monitor to open it. Default is 1, primary display,
%             2 means secondary display
%

    if nargin == 0
        monitor     = 1;
        padding     = 0;
    elseif nargin == 1
        monitor     = 1;
        padding     = varargin{1};
    elseif nargin == 2
        monitor     = varargin{2};
        padding     = varargin{1};
    end

    coords  = get(0,'MonitorPositions');
    if monitor > size(coords,1)
        error('Please choose a monitor that you actually have...');
    end

    coords  = coords(monitor,:) + [1/2*padding 1/2*padding -padding -padding];

    h = figure('Position',coords);

end
