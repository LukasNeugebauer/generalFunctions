function [folderHdf5] = convert2hdf5(folder)

%check for files
files   = dir([folder,filesep,'*.mat']);

%create new folder in target folder for new files in v7.3 (hdf5)
folderHdf5  = [folder,filesep,'v7.3'];

if ~exist(folderHdf5)
    
    mkdir(folderHdf5)
    fprintf('The folder %s has been created.\n',folderHdf5)
    
end

for ind = 1:numel(files)
    
    data = load([folder,filesep,files(ind).name]);
    p = data.p;
    save([folderHdf5,filesep,files(ind).name],'p','-v7.3')
    clear p
    
end

