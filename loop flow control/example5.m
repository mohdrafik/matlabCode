N=5;  list = rand(1,N); count_gt = 0;
  for ii = list
if ii> 0.5
    fprintf('random number value is greater than 0.5: %f\n',ii);
    count_gt = count_gt + 1;
end
  end
fprintf('total num gt >0.5 = %d\n',count_gt);

