function []     = convertBMP(folder,varargin)
%function []     = convertBMP(folder[,verbosity])
%
%Creates a new folder in 'folder' and stores 24 bit .bmp-versions of  all 
%8bit-.bmp-pictures in the specified directory. Ignores all other files  
%including other versions of .bmp
%
%Silence it with 
%   verbosity = 0; default is 1 because I like talking functions.
%02/13/2018 - Lukas Neugebauer

if nargin == 1
    verbosity = 1;
elseif nargin == 2 && any(varargin{1} == [0,1])
    verbosity = varargin{1};
else
    error('wrong number of arguments or wrong argument');
end

%add filesep character if necesary
if ~strcmp(folder,filesep)
    folder(end+1) = filesep;
end

%find and list pictures
D = dir([folder,'*.bmp']);

if numel(D) == 0
    disp('There were no files in the folder. Maybe you specified the wrong folder?');
    return;
end

%define function handles and bit depth
fun1    = @ind2rgb;
from    = 8;
to      = 24;
fun2    = @im2uint8;

warentrennbalken = repmat('=',1,20);

%define folder, create it if necessary
toFol   = sprintf('%s%dbit%s',folder,to,filesep);
if ~exist(toFol,'dir')
    mkdir(toFol);
    if verbosity
        fprintf('Created directory: %s\n%s\n',toFol,warentrennbalken);
    end
end

%actual conversion part, picture by picture
for nPix    = 1: numel(D)
    %read picture
    [dummyPix,dummyMap]   = imread([folder,D(nPix).name]);
    %automatically dedect correct direction of conversion and define folder
    if size(dummyPix,3) ~= 1
        if verbosity
            fprintf('%s has a wrong file format. This function can only handle 8 to 24 bit conversion.\nContinue with next picture\n%s\n',D(nPix).name,warentrennbalken);
        end
        continue
    end
    dummyPix    = feval(fun2,feval(fun1,dummyPix,dummyMap) );
    filename    = [toFol,D(nPix).name];
    imwrite(dummyPix,filename);
    dummyInf    = imfinfo(filename);
    if verbosity
        if dummyInf.BitDepth == to
            fprintf('Succesfully converted %s from %d to %d bits.\n',D(nPix).name,from,to);
        else
            fprintf('Something''s wrong with %s\nYou might want to check that.\n',D(nPix).name);
        end
    end    
end

end %end of function