function [Drone] = DetNextCell(Gs, drone, drn, t, t_fly, t_sensing, tabdist)
    
    %change "pointer"
    ind = find(drone(drn).tracker(1,:)==0,1);
    %update drone position -- where it is leaving
    drone(drn).tracker(1,ind) = drone(drn).path(drone(drn).tracker(3,ind-1));
    %update what's the next cell
    drone(drn).tracker(3,ind) = drone(drn).tracker(3,ind-1) + 1;
    if drone(drn).tracker(3, ind) > length(drone(drn).path)
        %the drone finished its current path
        
        %the path must be increased to cause periodicity
        drone(drn).path = [drone(drn).path,drone(drn).path];
    end
    
    o = drone(drn).path(drone(drn).tracker(3,ind-1));
    d = drone(drn).path(drone(drn).tracker(3,ind));
    
    if(o ~= d)
        drone(drn).tracker(2,ind) = t + t_fly*tabdist(o,d);
        drone(drn).tracker(4,ind) = t;
    else %the next cell is the same as the one the drone currently is
        
        %start sensing again
        drone(drn).state(1,ind) = t;
        drone(drn).state(2,ind) = 2;
        %determine when the drone starts sensing the next cell
        drone(drn).tracker(2,ind) = t + t_sensing;
        drone(drn).tracker(4,ind) = t;
    end
    
%     CellClear = ...
%         CheckIfOtherGoes(t, drn, drone, tabdist, Gs, t_fly, t_sensing);
    CellClear = ...
        CheckIfOtherGoes_2(drone, drn, t_sensing, t_fly, ...
                    drone(drn).path(drone(drn).tracker(3,ind)), tabdist);
    
    while CellClear == 0
        drone(drn).tracker(3,ind) = drone(drn).tracker(3,ind) + 1;
        
        if drone(drn).tracker(3, ind) > length(drone(drn).path)
            %the drone finished its current path
            
            %the path must be increased to cause periodicity
            drone(drn).path = [drone(drn).path,drone(drn).path];
        end
    
        o = drone(drn).path(drone(drn).tracker(3,ind-1));
        d = drone(drn).path(drone(drn).tracker(3,ind));
        
%         if d > length(drone(drn).path)
%             drone(drn).path = [drone(drn).path,drone(drn).path];
%         end
        
        if(o ~= d)
            drone(drn).tracker(2,ind) = t + t_fly*tabdist(o,d);
            drone(drn).tracker(4,ind) = t;
        else %the next cell is the same as the one the drone currently is
            
            %start sensing again
            drone(drn).state(1,ind) = t;
            drone(drn).state(2,ind) = 2;
            %determine when the drone starts sensing the next cell
            drone(drn).tracker(2,ind) = t + t_sensing;
            drone(drn).tracker(4,ind) = t;
        end
        
%         CellClear = ...
%             CheckIfOtherGoes(t, drn, drone, tabdist, Gs, t_fly, t_sensing);
        CellClear = ...
              CheckIfOtherGoes_2(drone, drn, t_sensing, t_fly, ...
                    drone(drn).path(drone(drn).tracker(3,ind)), tabdist);
        
        
    end
    
    Drone = drone(drn);
end