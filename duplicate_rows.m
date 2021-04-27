function dups = duplicate_rows(matA, matB, return_rows)
%function dups = duplicate_rows(matA, matB)
%
% Return the index of rows that exist in both matrices
% If return_rows is true, return the rows instead


    assert(size(matA, 2) == size(matB, 2), 'Matrices must have same number of columns');
    dups = find(ismember(matA, matB, 'rows'));
    if exist('return_rows', 'var') && return_rows
        dups = matA(dups, :);
    end

end
