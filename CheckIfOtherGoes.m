function [ClearCell] = CheckIfOtherGoes(t, uavRef, drones, tabdist, Gs, t_fly, t_sensing)
    ClearCell = -1;
    %estimated time when the UAVref gets to its next cell
    ind = find(drones(uavRef).tracker(2,:)==0,1) - 1;
    eta = drones(uavRef).tracker(2,ind);
    
    % the next cell to be visited by the drones
    wantedCell = drones(uavRef).path(drones(uavRef).tracker(3,ind));
    
    %for every other drones do:
    for drn = 1:length(drones)
        t_getsdere = t;
        t_finsen = t;
        if drn ~= uavRef
            istate = find(drones(drn).state(2,:)==0,1) - 1;
            % if that drone is sensing
            if drones(drn).state(2,istate) == 2 
                indtrck = find(drones(drn).tracker(2,:)==0,1) - 1;
                % if the cell the drone is sensing is the ONE
                if drones(drn).path(drones(drn).tracker(3,indtrck)) == wantedCell
                    %dont go
                    ClearCell = 0;
                    return;
                else %the drone is sensing something else
                    %define which cell it's sensing
                    dpos = drones(drn).path(drones(drn).tracker(3,indtrck));
                    %time when it finnished sensing this cell
                    t_finsen = GetWhenSenseDone(drones(drn), t_sensing);
                end
                
                nextcell = drones(drn).tracker(3,indtrck) + 1;
                %if the drone will end path after, check next
                if nextcell > length(drones(drn).path)
                    ClearCell = 1;
                end
                
                while ClearCell == -1
                    % if sensing done b4 eta
                    if t_finsen>= eta
                        
                        ClearCell = 1;
                        
                    else %drone has time to get to the cell
                        
                        %if this drone will go to the uref's next cell
                        if drones(drn).path(nextcell) == wantedCell
                            
                            t_getsdere = t_finsen + t_fly*tabdist( dpos, drones(drn).path(nextcell));
                            % if gets there b4 eta
                            if t_getsdere < eta
                                ClearCell = 0;
                            else % doesn't get there
                                ClearCell = 1;
                            end
                        else %it goes to some other cell after sensing this
                            t_getsdere = t_finsen + t_fly*tabdist( dpos, drones(drn).path(nextcell));
                            % if gets there b4 eta
                            if t_getsdere < eta
                                t_finsen = t_getsdere + t_sensing;
                                %estimated pos of the drones
                                dpos = drones(drn).path(nextcell);
                                %move tracker pointer
                                nextcell = nextcell + 1;
                                if nextcell > length(drones(drn).path)
                                    ClearCell = 1;
                                end
                            else %doesn't get there
                                ClearCell = 1;
                            end
                        end
                    end
                end
            else %the drone is moving
                indtrck = find(drones(drn).tracker(2,:)==0,1) - 1;
                
                %position it comes from
                prevpos = drones(drn).tracker(3,indtrck)-1;
                if prevpos < 1
                    prevpos = 1;
                end
                nextcell = drones(drn).tracker(3,indtrck);
                %dpos = drones(drn).tracker(1,t);
                dpos = WhereAmI_Flight(Gs.Graph, drones(drn), t, t_fly);
                %determine the time the drones will take to reach the next
                
                %pathing = shortestpath(G,drones(drn).path(prevpos),drones(drn).path(nextcell));
                %inpath = find(pathing == dpos,1);
                %pathing = pathing(inpath:end);
                %auxt = auxt + t_fly*(length(pathing)-1);
                t_getsdere = drones(drn).tracker(2,indtrck);
                
                % if next cell is the wanted one
                if drones(drn).path(nextcell) == wantedCell
                    % drone gets there b4 eta
                    if t_getsdere <= eta
                        ClearCell = 0;
                        return;
                    else % doesn't get there
                        ClearCell = 1;
                    end
                else % goes to some other
                    % if gets there b4 eta
                    if t_getsdere < eta
                        t_finsen = t_getsdere + t_sensing;
                        %estimated pos of the drones
                        dpos = drones(drn).path(nextcell);
                        %move tracker pointer
                        nextcell = nextcell + 1;
                        if nextcell > length(drones(drn).path)
                            ClearCell = 1;
                        end
                    else
                        ClearCell = 1;
                    end
                end
                %%%% HERE %%%%% (attention to auxt replacement
                t_getsdere = max(t_getsdere,t_finsen);
                while ClearCell == -1
                    %if next is wanted cell
                    if drones(drn).path(nextcell) == wantedCell
                        
                        t_getsdere = t_getsdere + t_fly*tabdist( dpos, drones(drn).path(nextcell));
                        
                        if t_getsdere < eta
                            ClearCell = 0;
                        else
                            ClearCell = 1;
                        end
                    else % drone goes to other cell
                        t_getsdere = t_getsdere + t_fly*tabdist( dpos, drones(drn).path(nextcell));
                        %gets there b4 the eta
                        if t_getsdere < eta
                            t_finsen = t_getsdere + t_sensing;
                            % finnishes sensing b4 eta
                            if t_finsen < eta
                                %estimated pos of the drones
                                dpos = drones(drn).path(nextcell);
                                %move tracker pointer
                                nextcell = nextcell + 1;
                                if nextcell > length(drones(drn).path)
                                    ClearCell = 1;
                                end
                            else
                                ClearCell = 1;
                            end
                        else
                            ClearCell = 1;
                        end
                    end
                end
                
                if ClearCell == 0
                    return;
                end
            end
        end
    end
end
