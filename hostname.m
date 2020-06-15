function [host] = hostname

    [~, host] = system('hostname');
    host = deblank(host);

end