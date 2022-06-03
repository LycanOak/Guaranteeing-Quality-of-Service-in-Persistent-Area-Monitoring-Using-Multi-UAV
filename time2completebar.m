function time2completebar(CompTime)
    %% M5 - 5%
    yM5_05 = zeros(5,2);
    xM5_05 = categorical({'A','B','C','D','E'});
    xM5_05 = reordercats(xM5_05,{'A','B','C','D','E'});
    for i = 1:5
        yM5_05(i,:) = [CompTime.M5.tsp.o5(i) CompTime.M5.bsl.o5(i)];
    end
    yM5_05 = yM5_05/10;
    b1 = figure();
    bar(xM5_05, yM5_05);
    fonttitlelabels = 16;
    fontlgd = 30;
    fontticks = 28;
    title('M = 5 with 5% Restricted Cells','FontSize', fonttitlelabels);
    xlabel('AoIs','FontSize',fonttitlelabels);
    ylabel('Time to Complete [u.t.]','FontSize',fonttitlelabels);
    lgd = legend( ...
        'TSP','Baseline','Location','southeast');
    lgd.FontSize = fontlgd;
    tight();
    set(b1, 'Position',  [100, 100, 1500, 1400]);
    set(gca,'FontSize',fontticks);
    filename = ['tspVbsl_M5_5','.png'];
    saveas(b1,filename);
    
    %% M5 - 10%
    yM5_10 = zeros(5,2);
    xM5_10 = categorical({'A','B','C','D','E'});
    xM5_10 = reordercats(xM5_10,{'A','B','C','D','E'});
    for i = 1:5
        yM5_10(i,:) = [CompTime.M5.tsp.o10(i) CompTime.M5.bsl.o10(i)];
    end
    yM5_10 = yM5_10/10;
    b1 = figure();
    bar(xM5_10, yM5_10);
    fonttitlelabels = 16;
    fontlgd = 30;
    fontticks = 28;
    title('M = 5 with 10% Restricted Cells','FontSize', fonttitlelabels);
    xlabel('AoIs','FontSize',fonttitlelabels);
    ylabel('Time to Complete [u.t.]','FontSize',fonttitlelabels);
    lgd = legend( ...
        'TSP','Baseline','Location','southeast');
    lgd.FontSize = fontlgd;
    tight();
    set(b1, 'Position',  [100, 100, 1500, 1400]);
    set(gca,'FontSize',fontticks);
    filename = ['tspVbsl_M5_10','.png'];
    saveas(b1,filename);
    
    %% M5 - 20%
    yM5_20 = zeros(5,2);
    xM5_20 = categorical({'A','B','C','D','E'});
    xM5_20 = reordercats(xM5_20,{'A','B','C','D','E'});
    for i = 1:5
        yM5_20(i,:) = [CompTime.M5.tsp.o20(i) CompTime.M5.bsl.o20(i)];
    end
    yM5_20 = yM5_20/10;
    b1 = figure();
    bar(xM5_20, yM5_20);
    fonttitlelabels = 16;
    fontlgd = 30;
    fontticks = 28;
    title('M = 5 with 20% Restricted Cells','FontSize', fonttitlelabels);
    xlabel('AoIs','FontSize',fonttitlelabels);
    ylabel('Time to Complete [u.t.]','FontSize',fonttitlelabels);
    lgd = legend( ...
        'TSP','Baseline','Location','southeast');
    lgd.FontSize = fontlgd;
    tight();
    set(b1, 'Position',  [100, 100, 1500, 1400]);
    set(gca,'FontSize',fontticks);
    filename = ['tspVbsl_M5_20','.png'];
    saveas(b1,filename);
    
    %% M10 - 5%
    yM10_05 = zeros(5,2);
    xM10_05 = categorical({'A','B','C','D','E'});
    xM10_05 = reordercats(xM10_05,{'A','B','C','D','E'});
    for i = 1:5
        yM10_05(i,:) = [CompTime.M10.tsp.o5(i) CompTime.M10.bsl.o5(i)];
    end
    yM10_05 = yM10_05/10;
    b1 = figure();
    bar(xM10_05, yM10_05);
    fonttitlelabels = 16;
    fontlgd = 30;
    fontticks = 28;
    title('M = 10 with 5% Restricted Cells','FontSize', fonttitlelabels);
    xlabel('AoIs','FontSize',fonttitlelabels);
    ylabel('Time to Complete [u.t.]','FontSize',fonttitlelabels);
    lgd = legend( ...
        'TSP','Baseline','Location','southeast');
    lgd.FontSize = fontlgd;
    tight();
    set(b1, 'Position',  [100, 100, 1500, 1400]);
    set(gca,'FontSize',fontticks);
    filename = ['tspVbsl_M10_05','.png'];
    saveas(b1,filename);
    
    %% M10 - 10%
    yM10_10 = zeros(5,2);
    xM10_10 = categorical({'A','B','C','D','E'});
    xM10_10 = reordercats(xM10_10,{'A','B','C','D','E'});
    for i = 1:5
        yM10_10(i,:) = [CompTime.M10.tsp.o10(i) CompTime.M10.bsl.o10(i)];
    end
    yM10_10 = yM10_10/10;
    b1 = figure();
    bar(xM10_10, yM10_10);
    fonttitlelabels = 16;
    fontlgd = 30;
    fontticks = 28;
    title('M = 10 with 10% Restricted Cells','FontSize', fonttitlelabels);
    xlabel('AoIs','FontSize',fonttitlelabels);
    ylabel('Time to Complete [u.t.]','FontSize',fonttitlelabels);
    lgd = legend( ...
        'TSP','Baseline','Location','southeast');
    lgd.FontSize = fontlgd;
    tight();
    set(b1, 'Position',  [100, 100, 1500, 1400]);
    set(gca,'FontSize',fontticks);
    filename = ['tspVbsl_M10_10','.png'];
    saveas(b1,filename);
    
    %% M10 - 20%
    yM10_20 = zeros(5,2);
    xM10_20 = categorical({'A','B','C','D','E'});
    xM10_20 = reordercats(xM10_20,{'A','B','C','D','E'});
    for i = 1:5
        yM10_20(i,:) = [CompTime.M10.tsp.o20(i) CompTime.M10.bsl.o20(i)];
    end
    yM10_20 = yM10_20/10;
    b1 = figure();
    bar(xM10_20, yM10_20);
    fonttitlelabels = 16;
    fontlgd = 30;
    fontticks = 28;
    title('M = 10 with 20% Restricted Cells','FontSize', fonttitlelabels);
    xlabel('AoIs','FontSize',fonttitlelabels);
    ylabel('Time to Complete [u.t.]','FontSize',fonttitlelabels);
    lgd = legend( ...
        'TSP','Baseline','Location','southeast');
    lgd.FontSize = fontlgd;
    tight();
    set(b1, 'Position',  [100, 100, 1500, 1400]);
    set(gca,'FontSize',fontticks);
    filename = ['tspVbsl_M10_20','.png'];
    saveas(b1,filename);
    
    %% M15 - 5%
    yM15_05 = zeros(5,2);
    xM15_05 = categorical({'A','B','C','D','E'});
    xM15_05 = reordercats(xM15_05,{'A','B','C','D','E'});
    for i = 1:5
        yM15_05(i,:) = [CompTime.M15.tsp.o5(i) CompTime.M15.bsl.o5(i)];
    end
    yM15_05 = yM15_05/10;
    b1 = figure();
    bar(xM15_05, yM15_05);
    fonttitlelabels = 16;
    fontlgd = 30;
    fontticks = 28;
    
    title('M = 15 with 5% Restricted Cells','FontSize', fonttitlelabels);
    xlabel('AoIs','FontSize',fonttitlelabels);
    ylabel('Time to Complete [u.t.]','FontSize',fonttitlelabels);
    lgd = legend( ...
        'TSP','Baseline','Location','southeast');
    lgd.FontSize = fontlgd;
    tight();
    set(b1, 'Position',  [100, 100, 1500, 1400]);
    set(gca,'FontSize',fontticks);
    filename = ['tspVbsl_M15_05','.png'];
    saveas(b1,filename);
    
    %% M15 - 10%
    yM15_10 = zeros(5,2);
    xM15_10 = categorical({'A','B','C','D','E'});
    xM15_10 = reordercats(xM15_10,{'A','B','C','D','E'});
    for i = 1:5
        yM15_10(i,:) = [CompTime.M15.tsp.o10(i) CompTime.M15.bsl.o10(i)];
    end
    yM15_10 = yM15_10/10;
    b1 = figure();
    bar(xM15_10, yM15_10);
    fonttitlelabels = 16;
    fontlgd = 30;
    fontticks = 28;
    title('M = 15 with 10% Restricted Cells','FontSize', fonttitlelabels);
    xlabel('AoIs','FontSize',fonttitlelabels);
    ylabel('Time to Complete [u.t.]','FontSize',fonttitlelabels);
    lgd = legend( ...
        'TSP','Baseline','Location','southeast');
    lgd.FontSize = fontlgd;
    tight();
    set(b1, 'Position',  [100, 100, 1500, 1400]);
    set(gca,'FontSize',fontticks);
    filename = ['tspVbsl_M15_10','.png'];
    saveas(b1,filename);

    %% M15 - 20%
    yM15_20 = zeros(5,2);
    xM15_20 = categorical({'A','B','C','D','E'});
    xM15_20 = reordercats(xM15_20,{'A','B','C','D','E'});
    for i = 1:5
        yM15_20(i,:) = [CompTime.M15.tsp.o20(i) CompTime.M15.bsl.o20(i)];
    end
    yM15_20 = yM15_20/10;
    b1 = figure();
    bar(xM15_20, yM15_20);
    fonttitlelabels = 16;
    fontlgd = 30;
    fontticks = 28;
    title('M = 15 with 20% Restricted Cells','FontSize', fonttitlelabels);
    xlabel('AoIs','FontSize',fonttitlelabels);
    ylabel('Time to Complete [u.t.]','FontSize',fonttitlelabels);
    lgd = legend( ...
        'TSP','Baseline','Location','southeast');
    lgd.FontSize = fontlgd;
    tight();
    set(b1, 'Position',  [100, 100, 1500, 1400]);
    set(gca,'FontSize',fontticks);
    filename = ['tspVbsl_M15_20','.png'];
    saveas(b1,filename);
    
    %% M20 - 5%
    yM20_05 = zeros(5,2);
    xM20_05 = categorical({'A','B','C','D','E'});
    xM20_05 = reordercats(xM20_05,{'A','B','C','D','E'});
    for i = 1:5
        yM20_05(i,:) = [CompTime.M20.tsp.o5(i) CompTime.M20.bsl.o5(i)];
    end
    yM20_05 = yM20_05/10;
    b1 = figure();
    bar(xM20_05, yM20_05);
    fonttitlelabels = 16;
    fontlgd = 30;
    fontticks = 28;
    title('M = 20 with 5% Restricted Cells','FontSize', fonttitlelabels);
    xlabel('AoIs','FontSize',fonttitlelabels);
    ylabel('Time to Complete [u.t.]','FontSize',fonttitlelabels);
    lgd = legend( ...
        'TSP','Baseline','Location','southeast');
    lgd.FontSize = fontlgd;
    tight();
    set(b1, 'Position',  [100, 100, 1500, 1400]);
    set(gca,'FontSize',fontticks);
    filename = ['tspVbsl_M20_05','.png'];
    saveas(b1,filename);
    
    %% M20 - 10%
    yM20_10 = zeros(5,2);
    xM20_10 = categorical({'A','B','C','D','E'});
    xM20_10 = reordercats(xM20_10,{'A','B','C','D','E'});
    for i = 1:5
        yM20_10(i,:) = [CompTime.M20.tsp.o10(i) CompTime.M20.bsl.o10(i)];
    end
    yM20_10 = yM20_10/10;
    b1 = figure();
    bar(xM20_10, yM20_10);
    fonttitlelabels = 16;
    fontlgd = 30;
    fontticks = 28;
    title('M = 20 with 10% Restricted Cells','FontSize', fonttitlelabels);
    xlabel('AoIs','FontSize',fonttitlelabels);
    ylabel('Time to Complete [u.t.]','FontSize',fonttitlelabels);
    lgd = legend( ...
        'TSP','Baseline','Location','southeast');
    lgd.FontSize = fontlgd;
    tight();
    set(b1, 'Position',  [100, 100, 1500, 1400]);
    set(gca,'FontSize',fontticks);
    filename = ['tspVbsl_M20_10','.png'];
    saveas(b1,filename);
    %% M20 - 20%
    yM20_20 = zeros(5,2);
    xM20_20 = categorical({'A','B','C','D','E'});
    xM20_20 = reordercats(xM20_20,{'A','B','C','D','E'});
    for i = 1:5
        yM20_20(i,:) = [CompTime.M20.tsp.o20(i) CompTime.M20.bsl.o20(i)];
    end
    yM20_20 = yM20_20/10;
    b1 = figure();
    bar(xM20_20, yM20_20);
    fonttitlelabels = 16;
    fontlgd = 30;
    fontticks = 28;
    title('M = 20 with 20% Restricted Cells','FontSize', fonttitlelabels);
    xlabel('AoIs','FontSize',fonttitlelabels);
    ylabel('Time to Complete [u.t.]','FontSize',fonttitlelabels);
    lgd = legend( ...
        'TSP','Baseline','Location','southeast');
    lgd.FontSize = fontlgd;
    tight();
    set(b1, 'Position',  [100, 100, 1500, 1400]);
    set(gca,'FontSize',fontticks);
    filename = ['tspVbsl_M20_20','.png'];
    saveas(b1,filename);
end