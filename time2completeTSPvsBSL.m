% draw histograms tsp vs bsl  timeto complete

function [time] = time2completeTSPvsBSL(p_base,tabdist)
    t_sensing = 20;
    t_fly = 30;
    
    time = 0;
    for pp = 1:length(p_base)
        time = time + t_sensing;
        if pp ~= length(p_base)
            time = time + t_fly*(tabdist(p_base(pp),p_base(pp+1)));
        else
            time = time + t_fly*(tabdist(p_base(pp),p_base(1)));
        end
    end
    
end