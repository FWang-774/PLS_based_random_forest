function [result] = test_oob(T, usedSample, X, Y)
 
% function [result] = test_oob(T, oobSample, X, Y)
% T : grown tree from grow_tree.m
% oobSample : out-of-bag sample index from bootstrap.m
% X : input data
% Y : input index
 
result.accuracy = [];
result.error = [];
result.classlabel = [];
result.cTabel = [];
result.weight = [];
result.weightdec = [];
 
orgIndex = [1 : max(size(Y))];
oobSample = removeindex(orgIndex, usedSample);
%--- extracting test samples
if isempty(oobSample)
    result.accuracy = 0;
    return;
end
 
ts = X(oobSample,:);
tsc = Y(oobSample);
 
num_instance = size(tsc,1);
cLabel = [];
 
[Yfit, NODE, estY] = treeval(T, ts);
estY = cell2num(estY);
 
[Acc, Err, cTable] = evaluate(estY, tsc);
result.accuracy = Acc;
result.error = Err;
result.classlabel = cLabel;
result.cTable = cTable;
 
%--- calculating weight
w = 0;
for i = 2 : size(cTable,1)
    w = w + cTable(i,i);
end
w = w / num_instance;
result.weight = w;
 
if (w / (1-w)) > 1
    result.weightdec = 1;
else
    result.weightdec = 0;
end