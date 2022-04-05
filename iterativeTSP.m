function [cell_timers, drone, cell, res, tfinal, t5] = iterativeTSP(G, drone,cell_timers, cell, t, t_sensing, t_fly, tabdist)
    tfinal = t;
    t5 = 0;
    Ndrones = length(drone);
    NObs = length(G.ObsIDs);
    NSpec = length(G.SpecIDs);
    
    
    savd = 0;
    drnpathlist = struct([]);
    for d = 1:length(drone)
        drnpathlist(d).plist = struct([]);
        drnpathlist(d).plist(1).p = drone(d).path;
    end
    
    %tightestD = 0;
    time2vstall = 0; %time it takes to visit every cell once ?
    %time it takes to finnish ??
    
    lapctr = zeros(1,(G.M)^2);
    
    lasttrade =  listoftrades(Ndrones);
    
    
    %     auxtrack2 = zeros(1,Ndrones);
    %     for dd = 1:Ndrones
    %         if startpos ~= drone(dd).path(1)
    %             auxtrack2(dd) = t + t_fly;
    %         end
    %     end
    
    while t >= 1
        %update timers
        cell_timers = cell_timers + 1;
        
        for drn = 1:Ndrones
            statenow = GetDroneState(drone(drn));
            if statenow == 2 %drone is sensing
                %check if the drone has finished the sensoring of the cell
                
                % instant of time when the drone changes into moving state
                if t >= GetWhenSenseDone(drone(drn), t_sensing) 
                    posnow = GetDronePos(drone(drn));
                    
                    lapctr(posnow) = lapctr(posnow) + 1;
                    
                    %update time of last visit
                    ind = find(cell(posnow).TimeLastVisit(1,:) == 0,1);
                    if ind ~= 1
                        cell(posnow).TimeLastVisit(1,ind) = t;
                        cell(posnow).TimeLastVisit(2,ind) = drn;
                    else
                        cell(posnow).TimeLastVisit(1,1) = t; %first time being sensed
                        cell(posnow).TimeLastVisit(2,1) = drn;
                    end
                    
                    cell_timers(posnow) = 0;
                    
                    ind = find(drone(drn).state(2,:)==0, 1);
                    drone(drn).state(1,ind) = t;
                    drone(drn).state(2,ind) = 1; %change to flying
                    
                    %  auxtrack2(drn) = t + t_fly;
                    
                    
                    
                    % determine the next cell to sense
                    drone(drn) = DetNextCell(G,drone, drn, t, t_fly, t_sensing, tabdist);
                else
                    posnow = GetDronePos(drone(drn));
                    cell_timers(posnow) = cell_timers(posnow) - 1;
                end
                
            else % drone is moving
                ind = find(drone(drn).tracker(1,:)==0, 1);
                %reaches cell to sense
                if t >= drone(drn).tracker(2,ind-1) 
                    
                    %Check Deadline - if this cell should have been visited
                    %earlier
                    [OD, newt, lasttrade, drone, cell_timers, cell, lapctr, drnpathlist] = ...
                        CheckDeadlines(G, t, cell_timers, cell, ...
                            drone(drn).path(drone(drn).tracker(3,ind-1)), ...
                            drone, drn, lasttrade, lapctr, drnpathlist);
                    
                    if OD == -1
                        res = -1;
                        return;
                    end
                    
                    if OD == 1
                        t = newt - 1; %newt or new t - 1 ????
                        lng = length(drnpathlist(drn).plist);
                        drnpathlist(drn).plist(lng+1).p =  drone(drn).path;

                        break;
                    else
                        %counter measure - if there is already other drone there
                        dthere = 0;
                        % get id of the cell we're reaching
                        dacell = drone(drn).path(drone(drn).tracker(3,ind-1));
                        
                        for dd = Ndrones
                            if dd ~= drn
                                inda = find(drone(dd).tracker(1,:) == 0,1);
                                if inda > 1
                                    inda = inda - 1;
                                    if drone(dd).state(2,inda) == 2 && ...
                                            drone(dd).path(drone(dd).tracker(3,inda)) == dacell
                                        dthere = 1;
                                        break;
                                    end
                                end
                                
                            end
                        end
                        if dthere ~= 1
                            ind = find(drone(drn).state(2,:)==0, 1);
                            drone(drn).state(1,ind) = t;
                            drone(drn).state(2,ind) = 2; %change to sensing
                        else %ignore cell move to next
                            drone(drn) = IgnoreThisCell(drone, drn, t, t_fly, t_sensing, tabdist);
                        end
                    end  
                end
            end
        end
        
        if sum(lapctr) <= 10*((G.M)^2-NObs+NSpec)
            if sum(lapctr) >= 7*((G.M)^2-NObs+NSpec) && ~savd
                t5 = t;
                savd = 1;
            end
            t = t + 1;
        else
            tfinal = t;
            t = -1;
        end
    end
    res = 1;
    
end