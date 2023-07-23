function [T] = grow_tree(tr, trc, depth, parent, parentidx)
 
% function [T] = grow_tree(tr, trc, depth)
% This function grows tree and returns tree T.
% tr  : train data
% trc : class label for train data
% sampleIndex: sample indices to know original sample indices
% depth : the depth of tree
% parent: parent node
% T   : tree matrix
%---------------------------------------------
%            Tree matrix 
% T := [depth | split_feature | parent | #of child | child | class]
% T(i,1) : depth
% T(i,2) : split feature
% T(i,3) : mean value
% T(i,4) : parent node
% T(i,5) : parent index
% T(i,6) : my index
% T(i,7) : the number of child node
% T(i,8 : 14) : child nodes
% T(i,15) : decided class
% T(i,16~): instances in current node
% Maximum depth: to prevent infinite loop
global MAX_DEPTH T_LENGTH
MAX_DEPTH = 10000;
T_LENGTH = 15;
%set(0, 'RecursionLimit', 10000);
%--- initializing trees
T = [];
subtree = zeros(1,T_LENGTH);
     
if nargin < 4
    depth = 0; 
    myidx = 0;
end
 
if nargin < 5
    parent = 0;
    parentidx = 0;
end
 
%depth = depth + 1;
myidx = parentidx + 1;
   
%--- extracting unique class label
%cLabel = unique(trc);
 
%--- get tree information
[minfo, datainfo] = mutualinfo(tr, trc);
 
%--- if maximum depth is reached
if (depth >= MAX_DEPTH) | (minfo.Gains(1) <= 0)
    subtree(1,1) = depth;                  % current depth
    subtree(1,2) = minfo.bestSplit(1,1);   % best split feature
    subtree(1,3) = minfo.bestSplit(1,2);   % meanvalue
    subtree(1,4) = parent;                 % parent node
    subtree(1,5) = parentidx;              % parent index
    subtree(1,6) = myidx;                  % my index
    subtree(1,7) = 0;                      % number of child node
    subtree(1,15) = majorvote(trc);
    T = [T; subtree];
    return;
end
 
subtree(1,1) = depth;                 % depth of leaf node
subtree(1,2) = minfo.bestSplit(1,1);  % best split feature
subtree(1,3) = minfo.bestSplit(1,2);  % mean value        
subtree(1,4) = parent;                % parent node
subtree(1,5) = parentidx;             % parent index
subtree(1,6) = myidx;                 % my index
     
%--- if every samples are in same class
if issame(trc) | issame(tr)
    subtree(1,7) = 0;                     % number of child nodes
    subtree(1,15) = majorvote(trc);       % decided class
    T = [T; subtree];
    return;
else
    numnode = size(minfo.bestSplit,1);
    subtree(1,7) = numnode;                % number of child nodes
    for i = 1 : numnode
        subtree(1, 7 + i) = minfo.bestSplit(i,4);   % child nodes
    end
    subtree(1,15) = majorvote(trc);
    T = [T; subtree];
end
 
%--- information about minfo
% minfo.bestSplit(k,1) : best feature
% spSampleX(k,2)       : mean value
% spSampleX(k,3)       : Number of splits
% spSampleX(k,4)       : attribute value to separate samples
% spSampleX(k,5~)      : Splited samples 
 
%--- recursively extend child nodes
for i = 1:subtree(7)
    cur_depth = depth + 1;
    myparentidx = parentidx + 1;
    myidx = myparentidx + 1;
    child_subtree = zeros(1,T_LENGTH);
    remainsamples = removezero(minfo.bestSplit(i,5:end));
    %--- if remained samples are in same class then this node becomes leaf node
    %--- extracting samples in current node
    curtr = tr(remainsamples, :); curtrc = trc(remainsamples);
    if issame(curtrc)
        child_subtree(1,1) = cur_depth;             % depth of leaf node
        child_subtree(1,2) = minfo.bestSplit(i,1);  % best split feature
        child_subtree(1,3) = minfo.bestSplit(i,2);  % mean value        
        child_subtree(1,4) = subtree(7+i);  % parent node
        child_subtree(1,5) = myparentidx;           % parent index
        child_subtree(1,6) = myidx;                 % my index
        child_subtree(1,7) = 0;                     % number of child nodes
        child_subtree(1,15) = majorvote(curtrc);    % decided class
        T = [T; child_subtree];  
    else
        %-- If they are not the same class then extend them.
        child_subtree = grow_tree(curtr, curtrc, cur_depth, minfo.bestSplit(i,4), myidx);
        T = [T; child_subtree];
    end
end