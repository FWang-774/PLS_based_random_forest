function [t,w] = PLS_manual(X,Y)
pzeg = [X Y];
mu=mean(pzeg);sig=std(pzeg); %??????? 
rr=corrcoef(pzeg);   % ??????? 
data=zscore(pzeg); % ????? 
n=size(X,2);m=1;   %n ???????,m ??????? 
x0=pzeg(:,1:n);y0=pzeg(:,n+1:end); 
e0=data(:,1:n);f0=data(:,n+1:end);  
num=size(e0,1);%??????? 
chg=eye(n);  %w ?w*???????? 
ii = 0;
for i=1:n 
% ????w?w*?t ?????? 
        ii = ii + 1;
        matrix=e0'*f0*f0'*e0; 
        [vec,val]=eig(matrix); % ????????? 
        val=diag(val);   %??????? 
        [val,ind]=sort(val,'descend'); 
        w(:,i)=vec(:,ind(1));    % ?????????????? 
        w_star(:,i)=chg*w(:,i);  % ??w*??? 
        t(:,i)=e0*w(:,i);        %???? ti ??? 
        alpha=e0'*t(:,i)/(t(:,i)'*t(:,i));  %?? alpha_i 
        chg=chg*(eye(n)-w(:,i)*alpha');     %??w ?w*????? 
        e=e0-t(:,i)*alpha';     %?????? 
        e0=e; 
    % ????ss(i) ?? 
        beta=[t(:,1:i),ones(num,1)]\f0;   %???????? 
        beta(end,:)=[];   %?????????? 
        cancha=f0-t(:,1:i)*beta;    %????? 
        ss(i)=sum(sum(cancha.^2));  %?????? 
    % ????press(i) 
        for j=1:num 
                t1=t(:,1:i);f1=f0; 
                she_t=t1(j,:);she_f=f1(j,:);  % ?????j ???????? 
                t1(j,:)=[];f1(j,:)=[];        %???j ???? 
                beta1=[t1,ones(num-1,1)]\f1;  %???????? 
                beta1(end,:)=[];           % ?????????? 
                cancha=she_f-she_t*beta1;  % ????? 
                press_i(j)=sum(cancha.^2);  
        end 
        press(i)=sum(press_i); 
        if i>1 
            Q_h2(i)=1-press(i)/ss(i-1); 
        else 
            Q_h2(1)=1; 
        end 
%     if Q_h2(i)<0.0975 
%         if Q_h2(i)<0.0025
%                 fprintf('???????r=%d',i); 
%                 r=i; 
%                 break 
%         end 
        if ii>4
                fprintf('???????r=%d',i); 
                r=i; 
                break 
        end 
end 
beta_z=[t(:,1:r),ones(num,1)]\f0;   %?Y ??t ????? 
beta_z(end,:)=[];      % ????? 
xishu=w_star(:,1:r)*beta_z;   %?Y ??X ?????????????????????????????? 
mu_x=mu(1:n);mu_y=mu(n+1:end); 
sig_x=sig(1:n);sig_y=sig(n+1:end); 

for i=1:m 
    ch0(i)=mu_y(i)-mu_x./sig_x*sig_y(i)*xishu(:,i);  %??????????????? 
end 
for i=1:m 
    xish(:,i)=xishu(:,i)./sig_x'*sig_y(i);  % ????????????????????????? 
end 
sol=[ch0;xish]      % ??????????????????????????????? 
save mydata x0 y0 num xishu ch0 xish

load mydata 
num 
ch0=repmat(ch0,num,1);    
yhat=ch0+x0*xish; % ??y ???? 
y1max=max(yhat); 
y2max=max(y0);  
ymax=max([y1max;y2max]) 
cancha=yhat-y0; % ???? 
% figure
% bar(xishu') 

