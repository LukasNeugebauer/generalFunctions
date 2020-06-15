function [] = create_if_necessary(folder)
    
    if ~exist(folder, 'dir')
        mkdir(folder);
    end
    
end