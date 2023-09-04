function [add,Averg,sum_square]  = func_example(x,y,z)
 add = x+y+z;
 Averg = add/3;
 sum_square = x^2 + y^2 +z^2;
fprintf('\naddition of 3 num:%d\n\t',add);
fprintf('\nAverage of num:%3.3f\n\t',Averg);
fprintf('\nSum of the sqaure of num:%d\n\t',sum_square);
end























