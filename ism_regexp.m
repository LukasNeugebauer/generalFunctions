function [log_out]   = ism_regexp(strCell,patternCell)
%function [log_out]   = ism_regexp(strCell,patternCell)
%
%Combination of ismember and regexp. Determines which strings in a cell can
%be matched by any of several patterns.
%
%Input:
%       strCell     - cell vector of strings to be matched
%       patternCell - cell vector of 1 - multiple regular expressions.
%
%Ouput:  
%       log_out     - logical vector indicating which of the strCell 
%                     elements could be matched by one of the patterns
%
%23.04.2018 - Lukas Neugebauer

%check input
if ~iscell(strCell) || ~iscell(patternCell) || ~isvector(strCell) || ~isvector(patternCell)
    error('Input must be cell vectors.\n');
end

%make everything a column vector and make sure output matches input
%afterwards
if  ~iscolumn(strCell) && isrow(strCell)
    reFun       = @asRow;
    strCell     = strCell';
else
    reFun       = @(x) x; %dummy function 
end
if ~iscolumn(patternCell) && isrow(patternCell)
   patternCell  = patternCell'; 
end

%couldn't think of a more elegant way than a loop unfortunately. Will maybe
%think about it again some other time.
log_array   = false(numel(strCell),numel(patternCell));

%check for every pattern
for np = 1:numel(patternCell)
    log_array(:,np)     = ~cellfun(@isempty,regexp(strCell,patternCell{np}));
end

%combine results and make them match input (row for row, column for column
%vector)
log_out     = any(log_array,2);
log_out      = reFun(log_out); 

end