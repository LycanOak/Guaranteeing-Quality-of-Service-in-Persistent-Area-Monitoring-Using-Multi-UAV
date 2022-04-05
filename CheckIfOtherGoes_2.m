function [ClearCell] = CheckIfOtherGoes_2(drone, ref, t_sensing, t_fly, intID, tabdist)
    indETA = find(drone(ref).tracker(2,:) == 0,1) - 1;
    ETA = drone(ref).tracker(2,indETA);
    
    ClearCell = -1; %still needs to check the other drones
    for dd = 1:length(drone)
        
        if dd ~= ref
            indst = find(drone(dd).state(2,:) == 0,1) - 1;
            %if the drone is sensing
            if drone(dd).state(2,indst) == 2
                stillnotover = 1;
                indStartSen = find(drone(dd).tracker(2,:) == 0,1) - 1;
                auxcsens = drone(dd).tracker(3,indStartSen);
                
                if drone(dd).path(auxcsens) == intID
                    %stillnotover = 0;
                    ClearCell = 0;
                    break;
                else
                    auxfinsen = drone(dd).tracker(2,indStartSen) + t_sensing;
                    auxp = drone(dd).path;
                    while stillnotover
                        if auxfinsen < ETA
                            prev = auxcsens;
                            auxcsens = auxcsens + 1;
                            if auxcsens > length(auxp)
                                auxp = [auxp, auxp];
                            end
                            auxeta = auxfinsen + t_fly*tabdist(auxp(prev),auxp(auxcsens));
                            if auxp(auxcsens) == intID
                                if auxeta <= ETA
                                    ClearCell = 0;
                                    stillnotover = 0;
                                else
                                    stillnotover = 0;
                                end
                            else
                                if auxeta < ETA
                                    auxfinsen = auxeta + t_sensing;                              
                                else
                                    stillnotover = 0;
                                end
                            end
                            
                        else
                            stillnotover = 0;
                        end
                    end
                    
                 
                end
                
            else
                stillnotover = 1;
                indIndNxtCell = find(drone(dd).tracker(3,:) == 0,1) - 1;
                
                auxeta = drone(dd).tracker(2,indIndNxtCell);
                auxnxt = drone(dd).tracker(3,indIndNxtCell);
                
                % emulate evolution of path
                if auxnxt > length(drone(dd).path)
                    auxp = [drone(dd).path, drone(dd).path];
                else
                    auxp = drone(dd).path;
                end
                
                while stillnotover 
                    %next cell to go is the cell of interest
                    if auxp(auxnxt) == intID
                        stillnotover = 0;
                        ClearCell = 0;
                    else
                        % reaches that cell before ETA
                        if auxeta < ETA
                            % finnishes sensing that cell before ETA
                            if auxeta + t_sensing < ETA
                                prev = auxnxt;
                                auxnxt = auxnxt + 1;
                                % emulate evolution of path
                                if auxnxt > length(auxp)
                                    auxp = [auxp, auxp];
                                end
                                
                                auxeta = auxeta + t_sensing + t_fly*tabdist(auxp(prev),auxp(auxnxt));
                            else
                                stillnotover = 0;
                            end
                        else
                            stillnotover = 0;
                        end
                    end  
                end
            end
        end  
        if ClearCell == 0
            return;
        end
    end
    if ClearCell ~= 0
        ClearCell = 1;
    end
    
end