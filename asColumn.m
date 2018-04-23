function[out] = asColumn(in)
%make sure that a vector is row vector. Output is input if that's the case.
if ~isvector(in)
    error('input must be vector');
end

if isrow(in)
    out = in';
elseif iscolumn(in)
    out = in;
end

end