function weekday_or_weekend(n)
switch n
case 1
fprintf('Sunday\n');
case {2,3,4,5,6}
fprintf('Weekday\n');
case 7
fprintf('Saturday\n');
otherwise
fprintf('Number must be from 1 to 7.\n');
end
end