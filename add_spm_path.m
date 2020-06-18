function [] = add_spm_path
    warning('off', 'all');
    addpath(genpath(fullfile(matlabroot, 'toolbox', 'spm12')));
    warning('on', 'all');
end