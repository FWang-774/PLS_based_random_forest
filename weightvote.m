function [C] = weightvote(W, Y)
 
% function [Y] = weightvote(Y)
% this function returns the result of majority vote based on the given
% class labels.
% W : weight for each tree
% Y : class labels
% C : decided class
 
cLabel = unique(Y);                  % unique class label
num_class = length(cLabel);       % number of different classes
num_tree = length(W);
scoreVector = zeros(num_class,1);    % number of votes for each class
 
if num_tree ~= length(Y)
    error('the number of weight is different from the number of trees');
end
 
for i = 1 : num_tree
    myclass = find(Y(i) == cLabel);
    scoreVector(myclass,1) = scoreVector(myclass,1) + W(i);
end
 
[max_score, corr_index] = max(scoreVector);
C = cLabel(corr_index);