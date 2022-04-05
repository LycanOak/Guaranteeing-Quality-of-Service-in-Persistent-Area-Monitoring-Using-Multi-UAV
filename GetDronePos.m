%==========================================================================
%   Determines the cell the drone just sensed 
%
% In:
%   drone - struct with info on one drone
%
% Out:
%   estTime - current state of the drone
%==========================================================================
function dpos = GetDronePos(drone)
    ind = find(drone.tracker(1,:) == 0, 1);
    
    ii = ind - 1;
    dpos = drone.path(drone.tracker(3,ii));
end