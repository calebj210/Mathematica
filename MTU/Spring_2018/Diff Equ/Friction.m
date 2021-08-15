% Time
maxTime = 25; % in seconds
iterations = 1000; 
t = linspace(0,maxTime,iterations);
dt = maxTime/iterations;

% Constants and butts and stuff
Fs = 5;
Fk = 2;
m = 100;
k1 = 10000;
k2 = 10000;

p = 1:iterations;
p(1) = 0;
v = 1:iterations;
v(1) = 0;
a = 1:iterations;

for i = 1:iterations-1
	F = 20*exp(-.5*(dt*i-3)^2);
	
	fs = Fs+(F-Fs)*exp(-k2*abs(F)/Fs);
	f = -sign(v(i))*(Fk+(fs-Fk)*exp(-k1*abs(v(i))));
	a(i) = (1/m)*(F+f);
	
	v(i+1) = v(i)+a(i)*dt;
	p(i+1) = p(i)+v(i)*dt;
end

F = 20*exp(-(dt*(i+1)-3)^2);

fs = Fs+(F-Fs)*exp(-k2*F);
f = Fk+(fs-Fk)*exp(-k1*abs(v(i+1)));
a(i+1) = (1/m)*(F-f);

plot(t,p,t,v,t,a,"LineWidth",2)
grid on
legend("Position","Velocity","Acceleration")