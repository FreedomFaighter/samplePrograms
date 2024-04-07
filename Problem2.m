function = diffSolver(min=0,max=400,gamma = 0.3,omega = 1.0, N=10000)
	dt = (max-min)/N;
	x = zeros(N,3);
	y = zeros(N,3);
	t = (1:N)*dt;
	x(1) = 1;
	y(1) = 1;
	epsilon = [0.15; 0.22; 0.25];
	for e = 1:3
    		for i = 2:N
        		x(i,e) = x(i-1,e) + dt*y(i-1,e);
        		y(i,e) = y(i-1,e) + dt*(x(i-1,e) - x(i-1,e)^3 - epsilon(e) * y(i-1,e) + gamma * cos(omega*t(i-1)));
    		end
	end
	for e= 1:3
    		figure
    		plot3(x(:,e),y(:,e),t);
	end
end