function [Precision Recall AccP AccN CC] = evctable(cTable)
 
% This function calculates precision, recall, accuracy in positive class,
% and accuracy in negative class
% cTable:    \ True | -1   | 1
%          Label___________________
%            -1     | A(TN)| B(FN)
%            -----------------------
%             1     | C(FP)| D(TP)
% Precision = D/(C+D);
% Recall = D/(B+D);
% AccN = A/(A+C);
% AccP = D/(B+D);
 
if (size(cTable,1) == 2) && (size(cTable,2) == 2)
    Precision = 100;
    Recall = 100;
    AccP = 100;
    AccN = 100;
    CC = 1;
    return;
end
 
%-- recall
if (cTable(2,3) + cTable(3,3)) == 0
    Recall = 0;
else
    Recall = (cTable(3,3) / (cTable(2,3) + cTable(3,3))) * 100;
end
 
%--- precision
if (cTable(3,2) + cTable(3,3)) == 0
    Precision = 0;
else
    Precision = (cTable(3,3) / (cTable(3,2) + cTable(3,3))) * 100;
end
 
%--- Accuracy in Negative
if (cTable(2,2) + cTable(3,2)) == 0
AccN = 0;
else
AccN = (cTable(2,2) / (cTable(2,2) + cTable(3,2))) * 100;
end
 
%--- Accuracy in Positive
if (cTable(2,3) + cTable(3,3)) == 0
AccP = 0;
else
AccP = (cTable(3,3) / (cTable(2,3) + cTable(3,3))) * 100;
end
 
%--- Correlation coefficient
tmpCC = (cTable(3,3)+cTable(2,3)) * (cTable(3,3)+cTable(3,2)) * (cTable(2,2)+cTable(3,2)) * (cTable(2,2)+cTable(2,3));
 
if tmpCC == 0
    CC = 0;
else
    CC = (cTable(2,2)*cTable(3,3) + cTable(3,2)*cTable(2,3)) / sqrt(tmpCC);
end