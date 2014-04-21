l = 1;
T = 1;
t = [10^-4 10^-3 10^-2];
x = 0:1/20:1;
m = length(x);
N = [length(0:t(1):1) length(0:t(2):1) length(0:t(3):1)];
h = l / m;
k = T / N(:);
f = @(x)sin(pi*x);
lambda = k / h^2;
w = zeros(m-1,length(lambda));
for p = 1:length(lambda)
    for i = 1:m-1
        w(i,p) = f(i*h);
    end
end
l = zeros(m-1, length(lambda));
l(1,:) = 1 + 2*lambda(:);
u = zeros(m-1, length(lambda));
u(1,:) = -lambda/l(1,:);
for p = 1:length(lambda)
    for i = 2:m-2
        l(i,p) = 1 + 2*lambda(p) + lambda(p)*u(i-1,p);
        u(i,p) = -lambda(p)/l(i,p);
    end
    l(m-1,p) = 1+2*lambda(p) + lambda(p)*u(m-2,p);
end

for p = 1:length(N)
    for j = 1:N(p)
        t = j * k(p);
        z = zeros(m);
        z(1) = w(1)/l(1);
        for i = 2:m-1
            z(i) = (w(i,p) + lambda(p)*z(i-1))/l(i);
        end
        w(m-1) = z(m-1);
        for i = m-2:-1:1
            w(i,p) = z(i) - u(i)*w(i+1,p);
        end
    end
end