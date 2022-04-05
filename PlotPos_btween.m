%==========================================================================
%   Gets the cells where the drone was between two cells to sense
%
% In:
%   G - Graph representation of the AoI
%   drone - info on the drone
%   ind - where to find info on tracker
% Out:
%   y - array with position and time with fly path
%==========================================================================
function [y] = PlotPos_btween(G, drone, ind, t_fly)
    o = drone.tracker(1,ind);
    d = drone.path(drone.tracker(3,ind));
    
    p = shortestpath(G,o,d);
    p = p(2:end-1); %cut orign and destination
    
    tstart = drone.tracker(4,ind);
    
    ts = ones(1,length(p));
    
    tt = tstart;
    for i = 1:length(ts)
        ts(i) = tt + t_fly;
        tt = ts(i);
    end
    
    y = [p;ts];
    
end