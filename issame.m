function [D] = issame(Y)
 
% function [D] = issame(Y)
% this function returns:
% 1 : all class labels are same
% 0 : class labels are different
% Y : class labels
% D : output
 
cLabel = unique(Y);     % unique class label
if max(size(cLabel)) == 1
    D = 1;
else
    D = 0;
end