%==========================================================================
%   Simulates the movement of the drone(s) without caring about the
%   deadlines of the cells. The purpose is to identify the behavior of the
%   system without control.
%
% In:
%   t - time instant to start the mission
%   startpos - position where all drones begin their mission
%   drone - struct with all info on drones
%   G - struct with all info on the AoI
%   cell - struct with info on all the cells
%   t_fly - time per distance unit to go from one cell to an adjacent one
%   t_sensing - time to sense one cell
%   cell_timers - array composed of the timers of each cell
%   tabdist - matrix of distances from all cells to every cell
%==========================================================================
function [cell_timers, drone, cell, res, tfinal, t5] = ...
        justfollowpath(t, drone, G, cell, t_fly, t_sensing, cell_timers, tabdist)
    
    Ndrones = length(drone);
    NObs = length(G.ObsIDs);
    NSpec = length(G.SpecIDs);
    
    
    savd = 0;
    res = 1; %result of the mission
    
    %tightestD = 0;
    time2vstall = 0; %time it takes to visit every cell once ?
                     %time it takes to finnish ??
    
    lapctr = zeros(1,(G.M)^2);
    
    
    
    
%     auxtrack2 = zeros(1,Ndrones);
%     for dd = 1:Ndrones
%         if startpos ~= drone(dd).path(1)
%             auxtrack2(dd) = t + t_fly;
%         end
%     end
    
    while t >= 1
        %update timers
        cell_timers = cell_timers + 1;
        
        for drn = 1:Ndrones
            statenow = GetDroneState(drone(drn));
            if statenow == 2 %drone is sensing
                %check if the drone has finished the sensoring of the cell
                if t >= GetWhenSenseDone(drone(drn), t_sensing) % instant of time when the drone changes into moving state
                    posnow = GetDronePos(drone(drn));
                    
                    lapctr(posnow) = lapctr(posnow) + 1;
                    
                    %update time of last visit
                    ind = find(cell(posnow).TimeLastVisit(1,:) == 0,1);
                    if ind ~= 1
                        cell(posnow).TimeLastVisit(1,ind) = t;
                        cell(posnow).TimeLastVisit(2,ind) = drn;
                    else
                        cell(posnow).TimeLastVisit(1,1) = t; %first time being sensed
                        cell(posnow).TimeLastVisit(2,1) = drn;
                    end
                    
                    cell_timers(posnow) = 0;
                    
                    ind = find(drone(drn).state(2,:)==0, 1);
                    drone(drn).state(1,ind) = t;
                    drone(drn).state(2,ind) = 1; %change to flying 
                    
%                     auxtrack2(drn) = t + t_fly;

                   

                    % determine the next cell to sense
                    drone(drn) = DetNextCell_JFP(drone(drn), t, t_fly, tabdist);
                else
                    posnow = GetDronePos(drone(drn));
                    cell_timers(posnow) = cell_timers(posnow) - 1;
                end
                
            else % drone is moving
                ind = find(drone(drn).tracker(1,:)==0, 1);
                if t >= drone(drn).tracker(2,ind-1) %reaches cell to sense
                    ind = find(drone(drn).state(2,:)==0, 1);
                    drone(drn).state(1,ind) = t;
                    drone(drn).state(2,ind) = 2; %change to sensing 
                end
            end
        end
        
        if sum(lapctr) <= 10*((G.M)^2-NObs+NSpec)
            if sum(lapctr) >= 5*((G.M)^2-NObs+NSpec) && ~savd
                t5 = t;
                savd = 1;
            end
            t = t + 1;
        else
            tfinal = t;
            t = -1;
        end
    end
    res = 1;
end