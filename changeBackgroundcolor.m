function [] = changeBackgroundcolor(folder,color,varargin)
%function [] = changeBackgroundcolor(color)
%
%use magicwand function to find background and change color. 
%color has to be scalar for grayscale and 8-Bit images, triplet for RGB and
%24-Bit images. Format of pictures is inferred from format of "color"
%input. Pictures can be of different 2D-size, but have to adhere to the
%depth size defined through color (i.e., 450x420x1 and 2688x87x1 are
%compatible for color input "120" but 420x92x1 and 420x92x3 will not be
%processed using only one color input, no matter its size).
%
%Loops through all pictures in a folder.
%
%varargin is "format" - default is .bmp. Not sure if anything will work tbh
%
%This function doesn't create a new folder where it writes the converted
%images, but actually changes the pictures in the folder - handle with
%care and have a back up somewhere else.
%
%23.02.2018 - Lukas Neugebauer

if nargin > 2 
    format = varargin{1};
else
    format = '.bmp';
end
if ismember(numel(color),[1,3])
    pixSize3    = numel(color);
else
    disp('wrong format of input argument ''color''');
    keyboard;
end

%add filesep character if necessary
if ~strcmp(folder(end),filesep)
    folder(end+1) = filesep;
end

%find pictures
D   = dir([folder,'*',format]);
c   = 0;
usedInd     = [];

%read in images im eligible, ignore otherwise. State it as output.
for nIm     = 1:numel(D)
    dummy   = imread([folder,D(nIm).name]);
    if size(dummy,3) == pixSize3
        c       = c+1;
        im{c}   = dummy;
        clear dummy;
        usedInd(c)  = nIm; 
        fprintf('Picture "%s" has been read and will be processed.\n',D(nIm).name);
    else
        fprintf('Picture "%s" has incompatible format and will be ignored.\n',D(nIm).name);
    end
end

%actually do stuff
for nIm     = 1:numel(usedInd)
    dummyIm             = repmat(im{nIm},1,1,3/pixSize3); %magicwand only accepts RGB, so just fake it if necessary
    dummyMask           = magicwand(dummyIm,1,1,1);
    for nDim = 1:pixSize3
        %lots of dummy stuff in this function...
        dummyIm2            = dummyIm(:,:,nDim);
        dummyIm2(dummyMask) = color;
        im{nIm}(:,:,nDim)   = dummyIm2;  
    end
    clear dummyIm dummyIm2 dummyMask;
    imwrite(im{nIm},[folder,D(usedInd(nIm)).name]);
    fprintf('Saved picture "%s" to %s.\n',D(usedInd(nIm)).name,folder);
end
    
end %end of function