function str = numformat(num)
 
% This function returns string type of integer
 
if num < 10
    str = sprintf('00%d', num);
elseif (num > 9) && (num < 100)
    str = sprintf('0%d', num);
else
    str = sprintf('%d', num);
end