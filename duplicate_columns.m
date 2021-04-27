function dups = duplicate_columns(matA, matB, return_columns)
%function dups = duplicate_columns(matA, matB, return_columns)
%
% Return the index of columns that exist in both matrices
% If return_columns is true, return the columns instead

    assert(size(matA, 1) == size(matB, 1), 'Matrices must have same number of rows');
    dups = find(ismember(matA', matB', 'rows'));
    if exist('return_columns', 'var') && return_columns
        dups = matA(:, dups);
    end

end
