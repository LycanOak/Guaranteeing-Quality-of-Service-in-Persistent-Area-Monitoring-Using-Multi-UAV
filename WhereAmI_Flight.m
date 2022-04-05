function pos = WhereAmI_Flight(graph, drone, t, t_fly)
    ind = find(drone.tracker(1,:)==0,1) - 1;
    
    timewindow = t - drone.tracker(4,ind);
    step = floor(timewindow/t_fly);
    sp = shortestpath(graph,drone.tracker(1,ind),drone.path(drone.tracker(3,ind)));
    if(step+1) > length(sp)
        pos = sp(end);
    else
        pos = sp(step+1);
    end
end