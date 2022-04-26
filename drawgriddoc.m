%try to draw AoI
M = 10;
[X,Y]=meshgrid(1:(M+1));
figure; hold on;
plot(X,Y,'k');
plot(Y,X,'k');axis off

% I=zeros(M+1);
% sc = surface(I,[1,0,0]);
% h=linspace(0.5,1,1);
% h=[1,0,0];
% set(gcf,'Colormap',h);

figure;
hold on;
X = [0 1];
Y = [1 1];
a = area(X,Y);
X = [2 3];
Y = [1 1];
a = area(X,Y);

% 
% N=M^2:-1:1;q=1;
% x=linspace(1.5,10.5,10);
% y=linspace(1.5,10.5,10);
% pp = sort(1:M,'descend');
% nn = sort(1:M,'descend');
% for p=pp
%     for n=nn
%         text(y(n)-.5,x(p),num2str(N(q)),'FontWeight','bold');
%         q=q+1;
%     end
% end