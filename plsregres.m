function [ytefit,training,testing] = plsregres( data_train,target_out,data_test,test_target )
SS=[];    
mse=[];  
num=size(data_train,1);%ѵ����������
weishu=size(data_train,2);
% for h=2:weishu %�ֱ���֤ѡȡ��ͬ�ĳɷ���ʱ���ɷ������ܶ���������  
%  ncomp=h;%�ɷ���  
[XL,YL,XS,YS,beta,PCTVAR,MSE]=plsregress(data_train,target_out);%���е�������ģ�����ɷ�����һ��h-1���ɷ֣�  
ytefit=[ones(size(data_test,1),1) data_test]*beta;%����������ģ��Ԥ��ֵ  
ytrfit=[ones(size(data_train,1),1) data_train]*beta;
[trrmse,trmae,trr2]=perfomance(target_out,ytrfit);
[termse,temae,ter2]=perfomance(test_target,ytefit);
training=[trrmse,trmae,trr2];
testing=[termse,temae,ter2];
% res=yfit-test_target;%�������  
% SS_h1=sum(res.^2);%ƽ����  
% SS_h1=sqrt(SS_h1/length(res));
%mse=[mse sum(MSE(2,:).^2)];  
% SS=[SS SS_h1];  
% end

