function [label,RMserf] = RFregression(tr,trc,ts,tsc )
 num_envfeat=5;
 num_tree=100;
 fid_log = fopen('myforestslog.txt', 'w');
result.majorlabel = [];
result.majoraccuracy = [];
result.majorerror = [];
result.majorctable = [];
result.weightlabel = [];
result.weightaccuracy = [];
result.weighterror = [];
result.weightctable = [];
result.weightlabel = [];
result.weight = [];
result.weightdecaccuracy = [];
result.weightdecerror = [];
result.weightdecctable = [];
result.weightdec = [];
result.allvote = [];
[num_sample, num_feat] = size(tr);
% if (num_envfeat > num_feat)
%     error('the number of envolved feature has to be smaller than original one');
% end 
voteSpace = []; Weight = []; WeightDec = [];
for i = 1 : num_tree
    if mod(i,5) == 0
        fprintf(fid_log, '        - %d/%d trees have been constructed.... \n',i,num_tree);        
        fprintf('        - %d/%d trees have been constructed.... \n',i,num_tree);
    end
    %--- processing bootstrp with replacement
%    fprintf('Bootstrapping....');
 [curtr, curtrc, selSamples] = bootstrapbal(tr, trc);
%     curtr=tr;
%     curtrc=trc;
%     selSamples=442;
%    fprintf('DONE!! \n');
    %--- choosing random feature
    [dummy, curfeat] = sort(rand(1,num_feat));
    curfeat = curfeat(1:num_envfeat);
    curtr = curtr(:, curfeat);
    curts = ts(:, curfeat);
    %--- growing a tree
%    fprintf('Growing tree with %dx%d samples are processing... ', size(curtr,1), size(curtr,2));
    T = grow_tree(curtr, curtrc);
%    fprintf('DONE!!\n');
    oobResult = test_oob(T, selSamples, tr(:, curfeat), trc);   % doing out-of-bag
    testResult = test_tree(T,curts,tsc);
    voteSpace = [voteSpace testResult.classlabel];
    trainresult=test_tree(T,tr(:,curfeat),trc);
   trainvote(i,:)=trainresult.classlabel;
end
 for i=1:size(voteSpace,1)
     label(i)=mean(voteSpace(i,:));
 end
 error=label-tsc';
 RMserf=roundn(sqrt(mean(error.^2)),-4);
end

