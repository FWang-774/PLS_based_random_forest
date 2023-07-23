function [Acc, Err, cTable] = evaluate(P, Y)
 
% function [Acc, Err, cTable] = evaluate(P, Y)
% This function evaluates the performance of classification
% === Variables ===
% Acc   : accuracy (%)
% Err   : error (%)
% cTable: confusion table
% P     : predicted classes
% Y     : actual classes
 
num_pred = length(P);
num_true = length(Y);
if (num_pred ~= num_true)
    fprintf('# of predicted instnaces %d \n',num_pred);
    fprintf('# of actual instances %d \n',num_true);
    error('Please check the number of instances are different!!');
end
 
T = 0; F = 0;
 
for i = 1 : num_true
    if P(i) == Y(i)
        T = T + 1;
    else
        F = F + 1;
    end
end
 
if (num_true ~= (T + F))
    error('Data is mismatched!!');
else
    Acc = T / num_true * 100;
    Err = F / num_true * 100;
end
 
cLabel = unique([P ; Y]);
num_label = length(cLabel);
cTable = zeros(num_label+1, num_label+1);
cTable(1,1) = 777;
for i = 1 : num_label
    cTable(i+1,1) = cLabel(i);
    cTable(1,i+1) = cLabel(i);
end
 
 
for i = 1 : length(Y)
    pre = find(P(i) == cTable(:,1));
    org = find(Y(i) == cTable(1,:));
    cTable(pre,org) = cTable(pre,org) + 1;
end