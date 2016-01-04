function varargout = linearize(varargin)
%LINEARIZE Takes any number of matrices and linearize them into a single column vector
%   linearize(a, b, c) where a, b and c are matrices of any dimensions will return a (n + 1) output values where the
%   first one is the linearized column vector as a result of concatenating all the elements from all of the input
%   matrices, and the subsequent n values will be function handles to "un-linearize" that big column vector.
%
%   Therefore,
%
%       > [big_vec fa fb fc] = linearize(a, b, c);
%
%   where column_vec contains all the elements from "a", "b" and "c" concatenated together will give us:
%
%       > fa(big_vec) == a
%       > fb(big_vec) == b
%       > fc(big_vec) == c
%
%   so that "fa", "fb" and "fc" are functions that are able to "un-linearize" "big_vec" into the original matrices "a",
%   "b" and "c", respectively.

big_vector = [];
L = length(varargin);
cumulative_index = 1;

for i = 1:L
    matrix = varargin{i};
    [n m] = size(matrix);
    linear_size = n * m;
    big_vector(end + 1: end + linear_size, :) = matrix(:);
    start_index = cumulative_index;
    end_index = cumulative_index + linear_size - 1;
    varargout{i + 1} = @(big_v) reshape(big_v(start_index:end_index), n, m);
    cumulative_index += linear_size;
end

varargout{1} = big_vector;

end
