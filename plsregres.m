function [ytefit,training,testing] = plsregres( data_train,target_out,data_test,test_target )
SS=[];    
mse=[];  
num=size(data_train,1);%训练集样本数
weishu=size(data_train,2);
% for h=2:weishu %分别验证选取不同的成分数时，成分数不能多于样本数  
%  ncomp=h;%成分数  
[XL,YL,XS,YS,beta,PCTVAR,MSE]=plsregress(data_train,target_out);%所有的样本建模，但成分数少一（h-1个成分）  
ytefit=[ones(size(data_test,1),1) data_test]*beta;%所有样本的模型预测值  
ytrfit=[ones(size(data_train,1),1) data_train]*beta;
[trrmse,trmae,trr2]=perfomance(target_out,ytrfit);
[termse,temae,ter2]=perfomance(test_target,ytefit);
training=[trrmse,trmae,trr2];
testing=[termse,temae,ter2];
% res=yfit-test_target;%误差向量  
% SS_h1=sum(res.^2);%平方和  
% SS_h1=sqrt(SS_h1/length(res));
%mse=[mse sum(MSE(2,:).^2)];  
% SS=[SS SS_h1];  
% end

