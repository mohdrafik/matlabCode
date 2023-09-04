 function example7(x)
% x = [2 9 8 2 13 ];
 sqaure_numV = 0;
  ii=1;
   while x(ii) < 10
           square_num = x(ii)*x(ii);
    sqaure_numV = [sqaure_numV,square_num];
     ii =ii+1;
   end
    sqaure_numV = sqaure_numV(2:end);
    disp(sqaure_numV);
     disp(x);
 end
 