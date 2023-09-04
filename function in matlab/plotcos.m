function plotcos(f1)
f1 = 50;
T = 1/f1 ;
t = 0:0.0001:2*T;  % cos2*pi*f0*t;
plot(t,cos(2*pi*f1*t),'-rs','MarkerFaceColor','k','MarkerSize',2);
xlabel('time'); ylabel('amplitude of sine');
title('plot of cosine with function example')
grid on;
 axis tight;
end