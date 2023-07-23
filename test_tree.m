function [result] = test_tree(T, X, Y)
 
if nargin < 3
    Y = [];
end
 
result.accuracy = [];
result.error = [];
result.classlabel = [];
result.cTable = [];
 
num_instance = size(X,1);
cLabel = [];
 
for i = 1 : num_instance
    Xinst = X(i,:);
    predict = trace_tree(T, Xinst);
    cLabel = [cLabel; predict];
end
 
if isempty(Y)
    result.classlabel = cLabel;
else
    [Acc, Err, cTable] = evaluate(cLabel, Y);
    [Precision Recall AccP AccN] = evctable(cTable);
    result.accuracy = Acc;
    result.error = Err;
    result.precision = Precision;
    result.recall = Recall;
    result.accPOS = AccP;
    result.accNEG = AccN;
    result.cTable = cTable;
    result.classlabel = cLabel;
end