function [Feature_Index] = removezero(Assigned_Index)
 
% This function remove zeros in the elements in Assigned_Index
% Assigned_index is column vector 
% -- Example --
% Assigned_Index = [1 2 3 4 0 0 7 0 9];
% Feature_Index = [1 2 3 4 7 9];
 
rows = size(Assigned_Index,1);
cols = size(Assigned_Index,2);
 
Feature_Index = [];
 
if rows > cols
    for i = 1 : rows
        if (Assigned_Index(i) > 0)
           Feature_Index = [Feature_Index; Assigned_Index(i)];
        end
    end
else
    for i = 1 : cols
        if (Assigned_Index(i) > 0)
           Feature_Index = [Feature_Index Assigned_Index(i)];
        end
    end
end