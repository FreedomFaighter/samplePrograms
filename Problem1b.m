function = numericalLaplacian(dx=0.1, dy=0.1, N=11, tol = 0.01, u_x_y = @(x,y) x*y+1)
	u = zeros(N,N);
	x=0:dx:1;
	y=0:dy:1;
	u(1,1:N) = u_x_y(x(1),y);
	u(1:N,1) = u_x_y(x,y(1));
	u(N,1:N) = u_x_y(x(N),y);
	u(1:N,N) = u_x_y(x,y(N));
	run=true;
	iterationsLessThanTolerance = 0;
	k = 0;
	while(run)
    		utemp = u;
    		utemp(2:N-1,2:N-1) = (u(1:N-2,2:N-1)+u(3:N,2:N-1)+u(2:N-1,1:N-2)+u(2:N-1,3:N))/4;
    		if(abs(u(2:N-1,2:N-1)-utemp(2:N-1,2:N-1)) < tol)
        		iterationsLessThanTolerance = iterationsLessThanTolerance + 1;
    		else
        		iterationsLessThanTolerance = 0;
    		end
    		if(iterationsLessThanTolerance == 2)
        		run=false;
    		end
    		u = utemp;
    		k = k + 1;
	end
	hold on;
	surf(u);
	hold off;
end
