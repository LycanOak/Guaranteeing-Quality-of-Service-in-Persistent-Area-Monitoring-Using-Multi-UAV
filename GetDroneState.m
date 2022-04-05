%==========================================================================
%   Determines the state of a certain drone at a given time
%
% In:
%   drone - struct with info on one drone
%
% Out:
%   dstate - current state of the drone
%==========================================================================
function dstate = GetDroneState(drone)
    ind = find(drone.state(2,:) == 0, 1);
    ii = ind - 1;
    dstate = drone.state(2,ii);
end
