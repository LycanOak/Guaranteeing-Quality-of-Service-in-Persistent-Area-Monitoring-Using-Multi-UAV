%========================================================================
% Defines the base path for the first drone
% In:
%   G - info on a AoI
%   startpos - cell where all the drones start
%========================================================================
function [p_base] = PathSelection(g, startpos)
    
    answer = questdlg('What is the base for the path of the drones?', ...
        'Path Selection', ...
        'TSP','Baseline','Baseline');
    % Handle response
    %figure;
    switch answer
        case 'TSP'
           tic;
            p_base = GeneralTSP(g.Graph, g.XD, g.YD, g.M, length(g.ObsIDs), g.ObsIDs, startpos);
            
            
            p_base = base_triming(p_base, g.ObsIDs);
            tspET = toc;
            savetsptime(tspET,g.M, p_base);
            %/\=/\=/\=/\=/\=/\ HERE /\=/\=/\=/\=/\=/\ HERE /\=/\=/\=/\=/\=/\
        case 'Baseline'
            tic;
            p_base = GenerateHamil(g.XD, g.YD, g.M);
            
            if ~isempty(g.ObsIDs)
                p_base = HamilIgnoreObs(p_base, g.ObsIDs);
            end
            bslET = toc;
            savetsptimeBSL(bslET,g.M, p_base);
 
    end
end