function [out1,out2,out3] = add_vect(x)
% dims = size(x);
sum =0;
for ii = 1:length(x)
    sum = sum + x(ii);
end
out1= sum;
fprintf('sum of vector: %d\n',out1);
out2 = sum/length(x);
fprintf('average of vector: %3.1f\n',out2);
out3 = find_maxofvect(x);
% out3 =NaN;
fprintf('out3 : %d\n',out3);
end

function maxnum = find_maxofvect(x)
flag1m=0;
for ii = 1:length(x)
    check_all = 0;
    for jj= 1:length(x)
        if x(ii)>x(jj) 
            check_all = check_all+1;
            if check_all == length(x)-1
                indx_ii = ii;
                flag1m =1;
                break
            end  
        end
    end 
    if flag1m ==1
        break
    end
end
maxnum = x(indx_ii);
end