function [subT] = instertinsts(subtree, instances, stpoint)
 
% function [subT] = instertinsts(subtree, instances, 16)
% this function returns new subtree which includes instances in current
% node
% subtree   : current subtree which needs to include current instnaces
% instances : instances in current node
% stpoint   : start point which will include instances
 
len_instances = max(size(instances));   % number of instances
subT = subtree;
 
for i = 1 : len_instances
    subT(stpoint + instances(i) - 1) = instances(i);
end