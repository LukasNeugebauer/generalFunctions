function [newStr] = myDeblank(oldStr)
%nifty little trick I stole from the internetz    
%remove all blanks from a string and return new blankless string
%worth its own function because it handels cells, char and strings and
%returns them in the same way by turning them into strings and back
    if ischar(oldStr)
        oldStr  = string(oldStr);
        backTransform = 1;
    else
        backTransform = 0;
    end
    %probably inefficient and eval is evil
    newStr   = eval([class(oldStr),'.empty']);
    for nStr = 1:numel(oldStr)
        %good luck you can index both strings and cells using curly brackets 
        newStr{nStr} = regexprep(oldStr{nStr},' +','');
    end
    if backTransform    
        newStr = char(newStr);
    end
end