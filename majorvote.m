function [C] = majorvote(Y)
 
% function [Y] = majorvote(Y)
% this function returns the result of majority vote based on the given
% class labels.
% Y : class labels
% C : decided class
 
cLabel = unique(Y);                  % unique class label
num_class = length(cLabel);       % number of different classes
scoreVector = zeros(num_class,1);    % number of votes for each class
 
for i = 1 : num_class
    scoreVector(i,1) = nnz(cLabel(i) == Y);
end
 
[max_score, corr_index] = max(scoreVector);
C = cLabel(corr_index);