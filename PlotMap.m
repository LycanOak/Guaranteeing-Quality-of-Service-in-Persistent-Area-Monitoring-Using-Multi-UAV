%==================================================================
% Plots the graph representation of a AoI
% In: 
%   G - struct containing info on the graph
% Out: -
%==================================================================
function PlotMap(G)
    fg = figure();
    nfs = 15*ones(1,G.M^2);
    gplot = plot(G.Graph,'XData',G.XD,'YData',G.YD, 'NodeFontSize', nfs);
    title(['Map of M = ',num2str(G.M)]);
    highlight(gplot, (1:G.M^2));
    if ~isempty(G.ObsIDs)
        highlight(gplot,G.ObsIDs,'NodeColor','r');
    end
    if ~isempty(G.SpecIDs)
        highlight(gplot,G.SpecIDs,'NodeColor','g');
    end
    
    
    filename = ['MapM',num2str(G.M),'.png'];
    saveas(fg,filename);
    
end