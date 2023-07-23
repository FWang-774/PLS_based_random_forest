function [DataX, DataY, selSamples] = bootstrapbal(X,Y,N)
 
% function [X] = bootstrap(X,Y,N)
% this function returns regenerated data set by bootstrap with replacement
% and the number of samples in all classes is balanced
% X : input data
% Y : class label
% N : if ratio is <= 1 then ratio of the number of samples in the class
%     which has the smallest number of samples
%     if ratio is > 1 then the samples in each class is selected by given
%     number. ex) N=10, there are 2 classes then total 20 samples are
%     selected. class1 will select 10 samples in this class and class2 will
%     select 10 samples for this class
%     if N is empty then the number of total samples in X will be
%     considered(Not balanced)
% DataX : new generated bootstrap data
% DataY : corresponding class label
% selSamples : Selected sample indices
 
num_instance = size(X,1);
 
if nargin < 3
    N = size(X,1);
    DataX = []; DataY = [];
    selSamples = unidrnd(N, N, 1);
    DataX = X(selSamples,:);
    DataY = Y(selSamples);
    selSamples = unique(selSamples);
    return;
end
 
cLabel = unique(Y);
if N <= 1
    %--- Finding the class which has the smallest number of samples
    numSamp = [];   % storage for the number of samples for each class
    for i = 1 : length(cLabel)
        numSamp = [numSamp; cLabel(i) nnz(Y == cLabel(i))];
    end
    [minVal minIdx] = min(numSamp(:,2));
    expSamp = round(minVal * N);   % Expecting the number of samples
else
    expSamp = N;
end
 
DataX = []; DataY = []; selSamples = [];
for i = 1 : length(cLabel)
    labIdx = find(Y == cLabel(i));
    tmpSamp = labIdx(unidrnd(length(labIdx), expSamp, 1));
    selSamples = [selSamples; tmpSamp];
    DataX = [DataX; X(tmpSamp,:)];
    DataY = [DataY; Y(tmpSamp,:)];
end
selSamples = unique(selSamples);