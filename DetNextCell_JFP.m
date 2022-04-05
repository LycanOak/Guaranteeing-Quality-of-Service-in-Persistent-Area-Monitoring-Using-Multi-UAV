%==========================================================================
%  Determines the next cell the drone is supposed to visit
% 
% In:
%   drone - struct with info on the drone
%   t - time instant
%   G - struct with info on the AoI
%   t_fly - time per distance unit to go from one cell to an adjacent one
%   t_sensing - time to sense one cell
% Out:
%   Drone - updated struct of the drone
%==========================================================================
function [Drone] = DetNextCell_JFP(drone, t, t_fly, tabdist)
    
    %change "pointer"
    ind = find(drone.tracker(1,:)==0,1);
    %update drone position -- where it is leaving
    drone.tracker(1,ind) = drone.path(drone.tracker(3,ind-1));
    %update what's the next cell
    drone.tracker(3,ind) = drone.tracker(3,ind-1) + 1;
    if drone.tracker(3, ind) > length(drone.path)
        %the drone finished its current path
        
        %the path must be increased to cause periodicity
        drone.path = [drone.path,drone.path];
    end
    
    o = drone.path(drone.tracker(3,ind-1));
    d = drone.path(drone.tracker(3,ind));
    drone.tracker(2,ind) = t + t_fly*tabdist(o,d);
    
    
    %/\=/\=/\=/\=/\=/\ HERE /\=/\=/\=/\=/\=/\ HERE /\=/\=/\=/\=/\=/\
    
    drone.tracker(4,ind) = t;
    

    Drone = drone;
end