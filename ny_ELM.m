%**************************************************************************
%TYUT
%FILE: Predict_ELM.m 
%VERSION: V4.0
%AUTHOR: Kang Yan
%DESCRIPTION: paper programming: 
%HISTORY: 2013-4-10 created
%         2013-4-12 modified

function [yfitELM ytrELM testing training] = ny_ELM(sat_train,sat_test,output_test)
%  function [TrainingAccuracy,TestingAccuracy] = ny_ELM(sat_train,sat_test)%for classifier program
%% ------------------------------ ELM!--------------------------------- 
%----------------------------train-------------------------------------
% tic;
[trrmse,trmae,trr2,ytrELM]=elm_train(sat_train, 0, 50, 'sig');
training=[trrmse,trmae,trr2];
% t1 =toc
% tic;
%----------------------------test--------------------------------------
[TestingTime, TestingAccuracy, yfitELM] = elm_predict(sat_test);
%     [learn_time, test_time, train_accuracy, test_accuracy,yfitELM]=ELM(sat_train,sat_test,0,1000,'sig');
residuals_ELM = yfitELM-output_test;
[termse,temae,ter2]=perfomance(output_test,yfitELM);
testing=[termse,temae,ter2];

% RMSEELM = sqrt(mean(residuals_ELM.^2));
% RMSEELM = roundn(RMSEELM,-4);
% t2=toc
%     xlswrite('temp2.xlsx',RMSEELM,'Sheet4',tablecell1); 
% %%the follwing program is for classifier
% [TrainingTime, TrainingAccuracy]=elm_train(sat_train, 1, 50, 'sig');
% [TestingTime, TestingAccuracy] = elm_predict(sat_test);
