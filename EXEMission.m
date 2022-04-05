
senseflag = zeros(1,Ndrones); %what cells are fully visited
maintainflag = zeros(1,Ndrones); %cells that are still being sensed

switch missiontype
    case 'Yes'
        tic;
        [cell_timers, drone, cell, res, tfinal, t5] = ...
            iterativeTSP(Gs(gg), drone, cell_timers, cell, t, ...
                         t_sensing, t_fly, tabdist);
        et = toc;
    case 'Just follow the path(s)'
        tic;
        [cell_timers, drone, cell, res, tfinal, t5] = ...
            justfollowpath(t, drone, Gs(gg), cell, t_fly, t_sensing, ...
                            cell_timers, tabdist);
        
        et = toc;
end

