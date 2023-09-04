x=[1:10];
count = 0;
for ii =1:length(x)
    if isscalar(x(ii))
        count =count +1;
        fprintf('i found scalar = %d\n',count);
    end   
end    