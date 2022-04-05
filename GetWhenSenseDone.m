%==========================================================================
%   Determines the time when the drone will change state
%
% In:
%   drone - struct with info on one drone
%
% Out:
%   estTime - current state of the drone
%==========================================================================
function estTime = GetWhenSenseDone(drone, t_sensing)
    
    ind = find(drone.tracker(1,:) == 0, 1);
    
    ii = ind - 1;
    estTime = drone.tracker(2,ii) + t_sensing;
    
end
