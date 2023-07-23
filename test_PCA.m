function [P,Lambda] = test_PCA(S)

S = S - repmat(mean(S),size(S,1),1); %归一化
C = (S'*S)./(size(S,1)-1); %C1 = cov(S); 协方差矩阵
[P,Lambda] = eig(C); %特征向量
S1 = S*P; %投影矩阵

