%=========================================================================
% Allocates space to save data on trades
% In:
%   Ndrones - number of drones of the mission
% Out:
%   lasttrades - struct with info on the trades performed earlier
%=========================================================================
function lasttrades = listoftrades(Ndrones)
    lasttrades.id = zeros(2,Ndrones);
    lasttrades.ind = zeros(2,Ndrones);
end