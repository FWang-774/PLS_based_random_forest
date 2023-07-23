function [predict] = trace_tree(T, X, depth, mynode, spfeat, mean_val)
 
if nargin < 3
    depth = 2;
    mynode = 1;
    spfeat = T(1, 2);         % best split feature
    mean_val = T(1, 3);       % find mean value to descrete
end
fix_X = X;
[X, num_val, valFeat, mean_val] = discrete(X,spfeat, 1, mean_val);
 
if X(1,spfeat) == T(depth,4) 
    if T(depth,7) == 0
        predict = T(depth,15);
        return;
    end
    spfeat = T(depth, 2);         % best split feature
    mean_val = T(depth, 3);       % find mean value to descrete  
    mynode = mynode + 1;
end
 
inc_depth = depth + 1;
%while mynode ~= T(inc_depth,1)
%    inc_depth = inc_depth + 1;
%end
deep = find(mynode == T(inc_depth:end,1));
if isempty(deep)
    predict = T(depth,15);
    return;
end
inc_depth = inc_depth + deep(1,1) - 1;
 
predict = trace_tree(T, fix_X, inc_depth, mynode, spfeat, mean_val);