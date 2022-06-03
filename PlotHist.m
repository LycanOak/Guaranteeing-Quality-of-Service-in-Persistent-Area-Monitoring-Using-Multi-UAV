%PLOT OVERALL HISTOGRAMS

fonttitlelabels = 24;
fontlgd = 16;
fontticks = 28;

aux.class = 0;
aux.info = [];
aux.mean = 0;
aux.std = 0;

hist_info = repmat(aux,length(groups),1);

for ii = groups
    hist_info(ii).class = ii - 1;
    hist_info(ii).info = Overall_info(cell, ii, Gs(gg), t_sensing);
    ok = 0;
    for jj = 1:length(hist_info(ii).info)
        if ~isempty(hist_info(ii).info(jj).TimeBtwnVisits)
            ok = 1;
            break;
        end
    end
    if ok == 1
        
        hit = [];
        for jj = 1:length(hist_info(ii).info)
            hit = [hit,hist_info(ii).info(jj).TimeBtwnVisits];
        end
        hist_info(ii).mean = mean(hit);
        hist_info(ii).std = std(hit);
        
        ff = figure();
        histogram(hit/10);
        
        cnt = 0;
        sum = 0;
        for uu = 1:length(cell)
            if cell(uu).Class == ii
                sum = sum + Gs(gg).Deadlines(uu);
                cnt = cnt + 1;
            end
        end
        AvgDead = sum/cnt;
        
        xline(AvgDead/10, 'Color', 'b', 'LineWidth', 3);
        xline(hist_info(ii).mean/10, 'Color', 'g', 'LineWidth', 3,'DisplayName','Mean');
        xline(hist_info(ii).mean/10 - hist_info(ii).std/10, 'Color', 'r', 'LineWidth', 3, 'LineStyle', '--','DisplayName','Standart Deviation');
        xline(hist_info(ii).mean/10 + hist_info(ii).std/10, 'Color', 'r', 'LineWidth', 3, 'LineStyle', '--', 'DisplayName','Standart Deviation');
        ax=gca;
        ax.FontSize = 18;
        title(['Overall Visitation for Class ',num2str(ii), ' M = ',num2str(Gs(gg).M)]);
        %legend('','Class Average Deadline','Mean', 'Standard Deviation','FontSize',fontlgd);
        formatSpec = '%.2f';
        lgd = legend( ...
                    [''],...
                    ['Average Deadline =',num2str(AvgDead/10)], ...
                    ['\mu = ',num2str(hist_info(ii).mean/10, formatSpec)], ...
                    ['\sigma = ',num2str(hist_info(ii).std/10, formatSpec)]);
        lgd.FontSize = fontlgd;
        %legend('','Mean', 'Standard Deviation','FontSize',16);
        ylabel('Number of Visits','FontSize',fonttitlelabels);
        xlabel('Time since last visit [s]','FontSize',fonttitlelabels);
        set(gca,'FontSize',fontticks);
        %tight();
        set(ff, 'Position',  [100, 100, 1500, 1400]);
        filename = ['OverallHistM',num2str(Gs(gg).M),'D',num2str(Ndrones),'C',num2str(ii),'.png'];
        saveas(ff,filename);
    end
end

