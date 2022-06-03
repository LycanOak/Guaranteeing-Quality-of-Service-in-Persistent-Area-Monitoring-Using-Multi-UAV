close all;
clearvars;

%AoIsizes = [5,10,15,20]
AoIsizes = ; %will be overwriten with Load

DefineAoIs
%
%NDrones = [1,2,3,4]
NDrones = 5;


%Start Mission
t = 1;
missiontype = questdlg('Do you wish the Deadlines to be controled?', ...
    'Problem Selection', ...
    'Yes','Just follow the path(s)','Yes');
%for every AoI
for gg = 1:length(Gs)
    
%     %save classes
%     groups = unique(Gs(gg).Deadlines);
%     for ii = 1:length(groups)
%         groups(ii) = floor(Gs(gg).DefaultDeadline/groups(ii));
%     end
%     deadliestlines(gg).closestMat = zeros( length(unique(groups)), length(NDrones));
%     

    %save classes
    groups = 1:5;
    
    deadliestlines(gg).closestMat = zeros( 6, length(NDrones));
    
    for nds = NDrones
        Ndrones = nds;
        ChooseDrones
        EXEMission
        disp(['M = ',num2str(Gs(gg).M),', D = ',num2str(Ndrones),', et = ',num2str(et)]);
        if res ~= -1
            PlotPos
            PlotHist
            %save closest deadline
            deadliestlines(gg) = SaveClosestDeadline( Gs(gg), deadliestlines(gg), groups, hist_info, NDrones, nds);
        end
    end
end