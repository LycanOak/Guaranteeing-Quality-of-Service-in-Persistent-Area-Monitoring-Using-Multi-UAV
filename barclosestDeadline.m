Classes = [1,3];
NDrones = 5;
y = zeros(NDrones,length(Classes));
x = categorical({'1','2','3','4','5'});
x = reordercats(x,{'1','2','3','4','5'});
for i = 1:5
    for j = 1:length(Classes)
        y(i,j) = [deadliestlines(1).closestMat(Classes(j)+1,i)];
    end
    
end


b1 = figure();
grid on;
bar(x, y);
fonttitlelabels = 16;
fontlgd = 30;
fontticks = 22;
title('Closest Deadlines','FontSize', fonttitlelabels);
xlabel('Number of Drones','FontSize',fonttitlelabels);
ylabel('Closeness to Deadline (%)','FontSize',fonttitlelabels);
yticks([0:5:100]);
ylim([0 100]);
classeslgn = [];
for i = Classes
    classeslgn = [classeslgn;'Class ',num2str(i)];
end

lgd = legend( ...
    classeslgn,'Location','southeast');
lgd.FontSize = fontlgd;
tight();
set(b1, 'Position',  [100, 100, 1500, 1400]);
set(gca,'FontSize',fontticks);
filename = ['CloseDead','.png'];
saveas(b1,filename);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%