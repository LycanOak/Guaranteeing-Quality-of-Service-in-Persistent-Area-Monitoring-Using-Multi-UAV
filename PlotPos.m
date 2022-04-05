%PLOT POSITIONS
    ff = figure();
    hold on;
    grid on;
    grid minor
    % different colors for every drone
    ditcol = distinguishable_colors(Ndrones);
    labels = strings([1, Ndrones]);
    
    for dd = 1:Ndrones
        droneid = sprintf('drone %d', dd);
        color = [ditcol(dd,1),ditcol(dd,2),ditcol(dd,3)];
        Colors(dd).colors = color;
        ind = find(drone(dd).tracker(4,:)>=t5,1);
        
        for ts = 0:5:t_sensing-1
            scatter((drone(dd).tracker(4,2:ind-1)+ts)/10,drone(dd).tracker(1,2:ind-1),...
                80,'d', ...
                'MarkerFaceColor', [color(1),color(2),color(3)], ...
                'MarkerEdgeColor',[color(1),color(2),color(3)], ...
                'LineWidth',2);
        end
        for ii = 1:ind
            drawbtween = PlotPos_btween(Gs(gg).Graph, drone(dd), ii, t_fly);
            scatter(drawbtween(2,:)/10,drawbtween(1,:),...
                40,'d', ...
                'MarkerFaceColor', 0.7*[color(1),color(2),color(3)], ...
                'MarkerEdgeColor',0.7*[color(1),color(2),color(3)], ...
                'LineWidth',2);
        end
        
        labels(dd) = droneid;
    end
    yticks(1:1:Gs(gg).M^2);
    ylabel('Cells','FontSize',24);
    xlabel('Time [s]','FontSize',24);
    
    h = zeros(Ndrones, 1);
    for dd = 1:Ndrones
        h(dd) = plot(0,0,'d', ...
            'MarkerFaceColor', [Colors(dd).colors(1),Colors(dd).colors(2),Colors(dd).colors(3)], ...
            'MarkerEdgeColor', [Colors(dd).colors(1),Colors(dd).colors(2),Colors(dd).colors(3)], ...
            'visible', 'on');
    end
    lgn = legend(h, labels);
    lgn.FontSize = 14;
    
    hold off;
    tight();
    set(ff, 'Position',  [100, 100, 1500, 1400]);
    filename = ['DronePos',num2str(Gs(gg).M),'D',num2str(Ndrones),'.png'];
    
    saveas(ff,filename);
    