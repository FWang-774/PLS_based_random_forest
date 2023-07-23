function [X, num_val, valFeat, mean_val] = discrete(X, feat, instidx, M)
 
% function [X, num_val, valFeat] = discrete(X,feat, instidx, M)
% this function discrete ith feature in data X by its mean value
% X       : input data
% feat    : the feature discreted by mean value
% instidx : instance index
% M       : the given mean value
% num_val : number of unique feature value
% valfeat : unique feature values after features are discreted
 
%---- normalization -----
neednorm = 0;
if neednorm
    normX = X(:,feat);
    [numinst,dummy] = size(normX);
    normX = norm(normX);
    for i = 1 : numinst
        if normX ~= 0
           X(i, feat) = X(i, feat) / normX;
        end
    end
end
 
 
if nargin < 3
    mean_val = mean(X(:,feat));
    for j = 1 : size(X,1)
        if X(j,feat) < mean_val
            X(j,feat) = 1;
        else
            X(j,feat) = 2;
        end
    end
    num_val = 2; valFeat = [1 ; 2];
    return;
else
    if X(instidx,feat) < M
        X(instidx,feat) = 1;
    else
        X(instidx,feat) = 2;
    end
    mean_val = M; num_val = 2; valFeat = [1 ; 2];
    return;
end