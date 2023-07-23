function [minfo, datainfo] = mutualinfo(X, Y)
 
% function [] = mutualinfor(X,Y)
% This function returns ordered feature set by information gain.
% minfo.orgFeatSet: Original feature set.
% minfo.ordFeatSet: Ordered new feature set.
% minfo.Gain      : Informaion gain
% minfo.bestSplit : Splited samples by best feature
% minfo.spSamples : Splited samples by each feature
% datainfo.num_class : the number of class
% datainfo.num_inst  : the number of smaples
% datainfo.num_feat  : the number of features
%--- Calculating information gain ---
% I(Y;X) = H(Y) + H(X) - H(Y,X)
%        = H(Y) - H(Y|X)
% X       : dataset
% Y       : class label
 
cLabel = unique(Y);              % used class labels
num_class = max(size(cLabel));   % Calculating the number of classes
cntClass = zeros(1,num_class);   % Array for counting the instances which belongs to each class
[num_inst, num_feat] = size(X);  % calculating the number of instances and features
 
%--- Initializing variables ---
minfo.orgFeatSet = [1 : num_feat];       % Original order of feature set
minfo.newFeatSet = [];      % Ordered feature set by information gain
minfo.Gains = [];           % Information gain for ordered feature set
minfo.bestSplit = [];
minfo.spSamples = [];
 
%--- Data information
datainfo.num_class = num_class;
datainfo.num_inst = num_inst;
datainfo.num_feat = num_feat;
 
%---------------- Calculating H(Y) -----------------
for i = 1 : num_inst
    for j = 1 : num_class
        if Y(i) == cLabel(j)
            cntClass(j) = cntClass(j) + 1;
        end
    end
end
 
if (sum(cntClass) ~= num_inst)
    error('Some Instances are missing!!!');
end
 
entropyY = 0; temp = 0;    % Calculating entropy of Y
 
for i = 1 : num_class
    if cntClass(i) == 0
        temp = 0;
    else
        temp = cntClass(i) / num_inst;
        temp = -1 * temp * log(temp);
    end
    entropyY = entropyY + temp;
end
 
%--- Data information
datainfo.entropyY = entropyY;
 
%---------------- Calculating H(Y|X) -----------------
infoEntropy = [];  spSamples = []; 
for i = 1 : num_feat
    [X, num_val, valFeat, mean_val] = discrete(X,i);
    cntVal = zeros(1,num_val);       % initializing array for counting values in a feature
    cntClass = zeros(num_val, num_class);   % initializing array for counting classes   
    spSampleX = zeros(num_val, num_inst+4);
    for j = 1 : num_inst
        for k = 1 : num_val                 % the number of unique values
            if X(j,i) == valFeat(k)
                cntVal(k) = cntVal(k) + 1;
                n = find(Y(j) == cLabel);
                cntClass(k,n) = cntClass(k,n) + 1;  % calculating P(Y|X)
                spSampleX(k,1) = i;                 % Feature index
                spSampleX(k,2) = mean_val;          % mean value
                spSampleX(k,3) = num_val;           % Number of splits
                spSampleX(k,4) = valFeat(k);        % attribute value to separate samples
                spSampleX(k,j+4) = j;               % Splited samples
            end
        end
    end
    spSamples = [spSamples; spSampleX];   % splited samples by each feature.
 
    %--- Checking error
    if (sum(cntVal) ~= num_inst)
        error('Some Instances are missing!!!');
    end
 
    entropyXY = 0; 
    for m = 1 : num_val
        temp = cntVal(m) / num_inst;   % P(X|X=x1)
        templog = 0; templog1 = 0;    
        for n = 1 : num_class
            if cntClass(m,n) == 0      % To prevent error for logarithm. i.e) log2(0)
                templog1 = 0;
            else
                templog1 = cntClass(m,n) / sum(cntClass(m,:));
                templog1 = -1 * templog1 * log(templog1);
            end
            templog = templog + templog1;
        end
        entropyXY = entropyXY + temp * templog;
    end
    infoEntropy = [infoEntropy entropyXY];   % accumulating entropy for each feature
end
 
%--- Calculating information gain
infoGain = entropyY - infoEntropy;
[sortGain, orgFeat] = sort(infoGain, 'descend');
 
%--- datainfo ---
datainfo.entropyXY = sort(infoEntropy);
 
%--- minfo ---
minfo.newFeatSet = orgFeat;
minfo.Gains = sortGain;
minfo.spSamples = spSamples;
bestSplit = find(orgFeat(1,1) == spSamples(:,1));
minfo.bestSplit = spSamples(bestSplit,:);