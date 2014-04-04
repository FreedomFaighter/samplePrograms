x = 0:1/20:1;
u_x_0 = @(x1) sin(pi*x1);
t = [10^-4;10^-3;10^-2];
t1 = 0:t(1):1;
t2 = 0:t(2):1;
t3 = 0:t(3):1;
numberOfXIterations = length(x);
numberOfTIterations = [length(t1);length(t2);length(t3)];
u1Backward = zeros(numberOfXIterations,numberOfTIterations(1));
u2Backward = zeros(numberOfXIterations,numberOfTIterations(2));
u3Backward = zeros(numberOfXIterations,numberOfTIterations(3));
alpha = t(1:3)/(1/20);
u1Backward(1:numberOfXIterations,numberOfTIterations(1)) = u_x_0(x);
tridiagonal = zeros(numberOfXIterations,numberOfXIterations,3);
for a = 1:3
    for i = 1:numberOfXIterations
        tridiagonal(i,i,a) = (1 + 2*alpha(a));
        if(i~=numberOfXIterations)
            tridiagonal(i,i+1,a) = -alpha(a);
            tridiagonal(i+1,i,a) = -alpha(a);
        end
    end
end
for j = (numberOfTIterations(1)-1):-1:1
    u1Backward(:,j) = tridiagonal(:,:,1)*u1Backward(:,j+1);
end
for j = (numberOfTIterations(2)-1):-1:1
    u2Backward(:,j) = tridiagonal(:,:,2)*u2Backward(:,j+1);
end
for j = (numberOfTIterations(3)-1):-1:1
    u3Backward(:,j) = tridiagonal(:,:,2)*u3Backward(:,j+1);
end