A= randi(10,2,3);
dims = size(A);
p = zeros(dims);
for ii=1:dims(1)
   for jj = 1:dims(2)
       p(ii,jj) = A(ii,jj)*A(ii,jj);
          
   end  
end  
disp(p)