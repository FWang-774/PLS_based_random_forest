function [P,Lambda] = test_PCA(S)

S = S - repmat(mean(S),size(S,1),1); %��һ��
C = (S'*S)./(size(S,1)-1); %C1 = cov(S); Э�������
[P,Lambda] = eig(C); %��������
S1 = S*P; %ͶӰ����

