%==========================================================================
% creates a struct that holds information on all the AoIs regarding size,
% structure, obstacles, deadlines.
% In:
%   Ms - All sizes for the AoIs
%
% Out:
%   Gs - Missions Struct
%==========================================================================
function [Gs] = Allgraphs(Ms, t_sensing, t_fly)
    Gs = struct;
    
    for i = 1:length(Ms)
        Gs(i).M = Ms(i);
        [Gs(i).Graph, Gs(i).XD, Gs(i).YD] = create_graph(Gs(i).M);
        Gs(i).DefaultDeadline = (Gs(i).M)^2*(t_sensing + t_fly); %seen as the deadline of a normal cell
        
        prompt = {'Enter Deadline of normal cells:'};
        dlgtitle = ['Deadline',num2str(Gs(i).M)];
        dims = [1 35];
        definput = {num2str(Gs(i).DefaultDeadline)};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        
        Gs(i).Deadlines = str2num(answer{1})*ones(1,(Gs(i).M)^2);
        
    end
    
    Gs = GetAoIObstacles(Gs);
    Gs = GetAoISpecialCells(Gs);
    
end