function maxnum1=  findmaxNum(x)
% this is function to find the maximum number from a  nonnegative vector.
 temp = 0;  %#ok<NASGU>
for ii = 1:length(x) 
    if x(ii)> temp
       temp = x(ii); 
    end
  maxnum1 = temp;
end