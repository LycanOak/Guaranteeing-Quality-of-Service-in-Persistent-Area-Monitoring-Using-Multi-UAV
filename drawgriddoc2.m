
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% X = [1 2 3; 1 2 3; 1 2 3];
% Y = X';
% mymap = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 0 0 0];
% C = [1 4 5; 3 2 5; 5 5 5];
% pcolor(X,Y,C);
% colormap(mymap);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
M = 20;
X = [];
for i = 1:M+1
    X = [X; 1:M+1];
end
Y = X';
%colors
% 1 - red    2 - green     3 - white      4  - black
mymap = [1 0 0; 0 1 0; 1 1 1; 0 0 0];
c = 3*ones(M);
% paint
c(1,2) = 1;
C = [c,4*ones(M,1)];
C = [C;4*ones(1,M+1)];
% C = [3 1 4; 3 3 4; 4 4 4];
pcolor(X,Y,C);
colormap(mymap);



