% function [ correlation coeffiR2 Accuracy ] = perfomance( original,prediction )
function [RMSE,MAE,R2]= perfomance( original,prediction )

%original represents the real value of the object,while prediction
%represents the predicted value.
% start computing the correlation
for i=1:length(original)
    numerator(i)=(original(i)-mean(original))*(prediction(i)-mean(prediction));%numerator代表分子
    a1(i)=(original(i)-mean(original))^2;
    b1(i)=(prediction(i)-mean(prediction))^2;
end
correlation=sum(numerator)/(sqrt(sum(a1)*sum(b1)));
%end correlation
%start computing coefficient of Determination(R^2)
R2=correlation^2;
%end R^2
%start computing Accuracy with different crition
% threshold=5;%please set the accepted error in which prediction result will be thought right
% count=0;
% for i=1:length(original)
%    if abs(original(i)-prediction(i)) <threshold
%        count=count+1;
%    end
% end
% Accuracy=count/length(original);
% %end Accuracy computing
% %start computing RMSE(Root mean squared error)
for i=1:length(original)
    error2(i)=(original(i)-prediction(i))^2;
    error1(i)=abs(original(i)-prediction(i));
end
RMSE=sqrt(sum(error2)/length(original));
% %end computing RMSE
% %start computing MSE（Mean Squared error）
% MSE=sum(error2)/length(original);%其表达式存在疑问
% %end
% %start computing MAE(Mean Absolute  Error)
MAE=sum(error1)/length(original);
% %end
% %start computing  MRE(Mean Relative Error or MAPE(mean absolute percentage error)
% MRE=sum(error1)/length(original);
%end
end

