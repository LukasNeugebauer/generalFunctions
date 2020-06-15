function [] = l(varargin)
%fake the alias l="ls -la"
    if isempty(varargin)
        folder = "";
    else
        folder = varargin{1};
    end
    eval(sprintf('ls -la %s', folder));
end