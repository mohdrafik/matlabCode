a = 14;
%while loop execution 
while a < 19
   a = a + 1; 
   if a == 16
      % skip the iteration 
      continue;
   end 
fprintf('value of a: %d\n', a);
end