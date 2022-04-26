%create a graph
M = 5;
Gs.M = M;
[Gs.Graph, Gs.XD, Gs.YD] = create_graph(M);

%%
for kk = 1:10
    %select now
    obsIDs = C(1).O005(kk).obs;
    
    %remove
    for oo = obsIDs
        nn = neighbors(Gs.Graph,oo);
        for ee = nn
            Gs.Graph = rmedge(Gs.Graph,oo,ee);
        end
        
    end
    
    tabdist = distances(Gs.Graph);
    
    startpos = 1;
    
    while ~isempty(find(obsIDs == startpos,1))
        startpos = startpos + 1;
    end
    
    %Generate Base Path for the drones
    p_base_tsp = GeneralTSP(Gs.Graph, Gs.XD, Gs.YD, Gs.M, length(obsIDs), obsIDs, startpos);
    p_base_tsp = base_triming(p_base_tsp, obsIDs);
    
    t_sensing = 20;
    t_fly = 30;
    
    time = 0;
    for pp = 1:length(p_base_tsp)
        time = time + t_sensing;
        if pp ~= length(p_base_tsp)
            time = time + t_fly*(tabdist(p_base_tsp(pp),p_base_tsp(pp+1)));
        else
            time = time + t_fly*(tabdist(p_base_tsp(pp),p_base_tsp(1)));
        end
    end
    
    time_tsp = time;
    
    %Generate Base Path for the drones
    p_base_bsl = GenerateHamil(Gs.XD, Gs.YD, Gs.M);
    
    if ~isempty(obsIDs)
        p_base_bsl = HamilIgnoreObs(p_base_bsl, obsIDs);
    end
    
    t_sensing = 20;
    t_fly = 30;
    
    time = 0;
    for pp = 1:length(p_base_bsl)
        time = time + t_sensing;
        if pp ~= length(p_base_bsl)
            time = time + t_fly*(tabdist(p_base_bsl(pp),p_base_bsl(pp+1)));
        else
            time = time + t_fly*(tabdist(p_base_bsl(pp),p_base_bsl(1)));
        end
    end
    
    time_bsl = time;
end