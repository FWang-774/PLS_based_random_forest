function [D Ub Lb]=problem_select(label)
switch label
    case 1 
        D=30;
        Lb=-100*ones(1,D);
        Ub=100*ones(1,D);
    case 2
        D=2;
         Lb=-4.5*ones(1,D);
         Ub=4.5*ones(1,D);
    case 3
        D=2;
        Lb=[-5,0];
        Ub=[10,15];
    case 4
       D=2;
        Lb=[-5,0];
        Ub=[10,15];
    case 5
      D=30;
        Lb=-600*ones(1,D);
        Ub=600*ones(1,D);  
    case 6
        D=3;
        Lb=zeros(1,D);
        Ub=ones(1,D);  
    case 7
       D=6;
        Lb=zeros(1,D);
        Ub=ones(1,D);   
    case 8
        D=30;
        Lb=-50*ones(1,D);
        Ub=50*ones(1,D);  
    case 9
        D=30;
        Lb=-50*ones(1,D);
        Ub=50*ones(1,D);  
    case 10
         D=30;
        Lb=-5.12*ones(1,D);
        Ub=5.12*ones(1,D);
    case 11
         D=30;
        Lb=-100*ones(1,D);
        Ub=100*ones(1,D);
    case 12
         D=2;
        Lb=-10*ones(1,D);
        Ub=10*ones(1,D);
    case 13
        D=4;
        Lb=zeros(1,D);
        Ub=10*ones(1,D); 
    case 14
         D=4;
        Lb=zeros(1,D);
        Ub=10*ones(1,D); 
    case 15
         D=4;
        Lb=zeros(1,D);
        Ub=10*ones(1,D); 
    case 16
        D=2;
        Lb=-5*ones(1,D);
        Ub=5*ones(1,D);
    case 17
        D=2;
        Lb=-10*ones(1,D);
        Ub=10*ones(1,D);
end
end

