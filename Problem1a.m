dx=0.1;
dy=0.1;
u_x_y = @(x,y) x*y+1;
N=11;
u = zeros(N,N);
x=0:dx:1;
y=0:dy:1;
for i = 1:11
    for j = 1:11
        u(i,j) = u_x_y(x(i),y(j));
    end
end
surf(u);

