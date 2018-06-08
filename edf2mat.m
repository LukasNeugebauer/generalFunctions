function [matFile] = edf2mat(edfFilename,varargin)
%function [matFile] = edf2mat(edfFilename[,targetFolder])
% 
%wrapper around 'edfread()'. Extracts appropriate messages and changes the
%fieldnames by deblanking them. 
%
%expected input:
%edfFilename:   is name of an .edf-file. must either be in your working
%               directory or absolute path
%
%variable input:
%
%targetFolder:  where to save the .mat-file. If not given is saved to same
%               directory as .mat-file
%
%IMPORTANT: This is meant to be run on a linux 64x machine since this is
%where edfread() runs. If it doesn't work you're most likely on another
%system.

    %check compatibility
     if ~strcmp(computer,'GLNXA64')
        error('Read the help and try again on an appropriate machine!')
    end

    %add path with edfread() to MATLAB path if needed
    pathToFun   = [filesep,'home',filesep,'onat',filesep,'Documents',filesep,'Code',filesep,'Matlab',filesep,'edfread',filesep,'current'];
    if ~any(strcmp(pathToFun,regexp(path,pathsep,'split')))
        addpath(pathToFun);
    end
    
    %check for absolute vs. relative path and make it absolute 
    if ~strcmp(edfFilename(1:6),[filesep,'home',filesep])
        edfFilename     = [pwd,filesep,edfFilename];
    end

    %create the mat file
    [dummyMat,meta]   = edfread(edfFilename,'TRIALID','TRIAL_RESULT','Stim Onset','Stim Offset','UCS Onset','UCS Offset'); %#ok<ASGLU>

    %now for the fieldname business
    names   = fieldnames(dummyMat);
    newNames = myDeblank(names);

    for x = 1:numel(newNames)
        [dummyMat(:).(newNames{x})]  = dummyMat(:).(names{x});
    end

    allnames    = fieldnames(dummyMat);
    keepIndex   = find(ismember(allnames,newNames));
    dummyCell   = struct2cell(dummyMat);

    newSize     = size(dummyCell);
    newSize(1)  = numel(keepIndex);

    matFile = cell2struct(reshape(dummyCell(keepIndex,:),newSize),newNames);

    [direc,name]    = fileparts(edfFilename);
    save([direc,filesep,name,'.mat'],'matFile','meta');
    fprintf('Saved .mat-file to %s\n',[direc,filesep,name]);
    
    function [newString] = myDeblank(oldString)
        newString   = cell(size(oldString));
        for y = 1:numel(oldString)
            newString{y} = regexprep(oldString{y},' +','');
        end
    end

end