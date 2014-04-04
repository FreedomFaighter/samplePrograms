
x = 0:1/20:1;
u_x_0 = @(x1) sin(pi*x1);
t = [10^-4;10^-3;10^-2];
t1 = 0:t(1):1;
t2 = 0:t(2):1;
t3 = 0:t(3):1;
numberOfXIterations = length(x);
numberOfTIterations = [length(t1);length(t2);length(t3)];
ut1Forward = zeros(numberOfXIterations,numberOfTIterations(1));

ut2Forward = zeros(numberOfXIterations,numberOfTIterations(2));

ut3Forward = zeros(numberOfXIterations,numberOfTIterations(3));


ut1Forward(1:numberOfXIterations,1) = u_x_0(x);
alpha = t(1:3)/(1/20)^2;
for j = 1:(numberOfTIterations(1)-1)
    for i = 2:20
        ut1Forward(i,j+1) = ut1Forward(i,j,1)+(alpha(1))*(ut1Forward(i-1,j) - 2*ut1Forward(i,j) + ut1Forward(i+1,j));
    end
end

ut2Forward(1:numberOfXIterations,1) = u_x_0(x);
for j = 1:(numberOfTIterations(2)-1)
    for i = 2:20
        ut2Forward(i,j+1) = ut2Forward(i,j)+(alpha(2))*(ut2Forward(i-1,j) - 2*ut2Forward(i,j) + ut2Forward(i+1,j));
    end
end
ut3Forward(1:numberOfXIterations,1) =  u_x_0(x);
for j = 1:(numberOfTIterations(3)-1)
    for i = 2:20
        ut3Forward(i,j+1) = ut3Forward(i,j)+(alpha(3))*(ut3Forward(i-1,j) - 2*ut3Forward(i,j) + ut3Forward(i+1,j));
    end
end

A1 = zeros(numberOfTIterations(1),numberOfTIterations(1));
for i = 1:numberOfTIterations(1)
   A1(i,i) = (1+2*alpha(1));
   if(i ~= numberOfTIterations(1))
        A1(i,i+1) = -alpha(1);
        A1(i+1,i) = -alpha(1);
   end
end

b1 = linsolve(A1,transpose(ut1Forward(2,:)));
x1 = (A1)\b1;

A2 = zeros(numberOfTIterations(2),numberOfTIterations(2));
for i = 1:numberOfTIterations(2)
   A2(i,i) = (1+2*alpha(2));
   if(i ~= numberOfTIterations(2))
        A2(i,i+1) = -alpha(2);
        A2(i+1,i) = -alpha(2);
   end
end
b2 = linsolve(A2,diag(A2,0));
x2 = (A2)\b2;

A3 = zeros(numberOfTIterations(3),numberOfTIterations(3));
for i = 1:numberOfTIterations(3)
   A3(i,i) = (1+2*alpha(3));
   if(i ~= numberOfTIterations(3))
        A3(i,i+1) = -alpha(3);
        A3(i+1,i) = -alpha(3);
   end
end
b3 = linsolve(A3,diag(A3,0));
x3 = (A3)\b3;

% ut1Backward(1:numberOfXIterations,numberOfTIterations(1)) =  u_x_0(x);
% for j = (numberOfTIterations(1)-1):1
%    for i = 2:20
%        ut1Backward(i,j) = ut1Backward(i,j+1) - (alpha(3))*(ut1Backward(i-1,j) - 2*ut1Backward(i,j) + ut1Backward(i+1,j));
%    end
% end
% ut2Backward(1:numberOfXIterations,numberOfTIterations(2)) =  u_x_0(x);
% for j = (numberOfTIterations(2)-1):1
%    for i = 2:20
%        ut2Backward(i,j) = ut2Backward(i,j+1) - (alpha(3))*(ut2Backward(i-1,j) - 2*ut2Backward(i,j) + ut2Backward(i+1,j));
%    end
% end
% ut3Backward(1:numberOfXIterations,numberOfTIterations(3)) =  u_x_0(x);
% for j = (numberOfTIterations(3)-1):1
%    for i = 2:20
%        ut3Backward(i,j) = ut3Backward(i,j+1) - (alpha(3))*(ut3Backward(i-1,j) - 2*ut3Backward(i,j) + ut3Backward(i+1,j));
%    end
% end