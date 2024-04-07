function = secondLaplaceInParallel(N=100, tol = 1/1000, u_x_y = @(x,y) x*y+1)
	x=0:1/N:1;
	y=0:1/N:1;
	u = zeros(length(x),length(y));
	for i = 1:length(x)
    		for j = 1:length(y)
        		u(i,j) = u_x_y(x(i),y(j));
    		end
	end
	run = true;
	k = 1;
	while(run)
    		u(2:N,2:N,k+1) = (u(1:N-1,2:N,k) + u(3:N+1,2:N,k)+u(2:N,1:N-1,k)+u(2:N,3:N+1,k)-4*u(2:N,2:N,k))/(1/(N-1))^2;
    		if(u(:,:,k+1)-u(:,:,k) < tol)
        		run = false;
    		end
    		k = k+1;
	end

surf(u(:,:,k));
end
