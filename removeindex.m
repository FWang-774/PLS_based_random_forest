function [FeatIndex] = removeindex(OrgIndex, RmIndex)
 
% This function removes the index from original index(OrgIndex) based on
% the reference Index (RmIndex).
% OrgIndex:    Original index
% RmIndex :    Reference index
% -- Example --
% OrgIndex = [1 2 3 4 5]; RmIndex = [2 4];
% FeatIndex = [1 3 5];
 
for i = 1 : max(size(RmIndex))
    OrgIndex(RmIndex(i)) = 0;
end
 
FeatIndex = removezero(OrgIndex);