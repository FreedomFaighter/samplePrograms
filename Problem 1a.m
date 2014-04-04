N=11
tol = 0.01

u = zeros(N,N,1)

for i=1:N
    u(i,1,1) = (i*1)/N^2+1
    u(i,N,1) = (i/N)+1
    u(1,i,1) = u(i,1,1)
    u(N,i,1) = u(i,N,1)
end

run=true
k=1
while(run)
    u(:,:,k+1) = u(:,:,k)

    u(2:N-1,2:N-1,k+1)= (u(1:N-2,2:N-1,k) + u(3:N,2:N-1,k) + u(2:N-1,3:N,k) + u(2:N-1,1:N-2,k))/ 4
    if(abs(u(2:N-1,2:N-1,k)-u(2:N-1,2:N-1,k+1)) < tol)
        run=false
    end
    k=k+1
end
fprintf('Converged after %i iterations with tolerance of %f: \n', k, tol)