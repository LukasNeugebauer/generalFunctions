function [] = keepMatlabAwake(varargin)
%function [] = keepMatlabAwake([hours][,frequency])
%
%This function will move the mouse from time to time so that your computer
%doesn't go to sleep while you want to run a lengthy process overnight or
%so. 
%There is probably a more elegant and simple way for this. Consider this a
%dirty workaround, but it is easy to implement and does what it should do.
%
%If you don't give any input, this script will run indefinetely until you
%press 'Escape'. If you define duration, it will stop afterwards. 
%             
%optional input:
%       hours       - for how long do you want this to run? Default is 
%                     until the end of time.
%
%       frequency   - frequency of mouse moves in minutes. Default is every
%                     5 minutes, which should be okay for most purposes
%
%OBVIOUSLY you have to run this in another instance of Matlab in case the
%process you use overnight runs in Matlab itself. 
%
%08.06.2018 - Lukas Neugebauer 

%handle duration
if nargin == 0 || (nargin == 2 && isempty(varargin{1}))
    hours   = Inf;
else
    hours   = varargin{1};
end
duration    = round(hours * 60.^2);  %has to be in second and natural number

%handle frequency
if nargin  < 2
    frequency   = 5;
else
    frequency   = varargin{2};
end
frequency     = round(frequency * 60); %see above

%get size of monitor
monSize     = get(0,'ScreenSize');
x           = monSize(4); 
y           = monSize(3);

%import java class Robot, that is going to do the work for us. Kudos to
%whoever programmed that one, it's a gem!
try
    import java.awt.Robot;
    ROBOT   = java.awt.Robot;
catch
    fprintf(['I don''t really have an idea what I''m trying to do here.\n',...
            'But there seems to be a problem with importing the Java class\n',...
            '"Robot". So maybe install the Java IDE or so? No idea, really...\n']);
end

%define escape key and keyCode variable
KbName('UnifyKeyNames');
escKey  = KbName('Escape');

%initialize variables
counter = 0;
keyCode = zeros(1,256);    

while counter < duration && ~keyCode(escKey) %keep on running whole duration or until escape key is pressed
   tic;
   [~,~,keyCode]    = KbCheck;  
   counter          = counter + 1;
   if mod(counter,frequency) == 0
       for z = 1:2
           ROBOT.mouseMove(x*rand,y*rand);
           WaitSecs(0.1);
       end
   end
   if toc <= 0.9999999
        WaitSecs(1-toc); %Wait for the rest of the second
   end
end