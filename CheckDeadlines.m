%======================================================================
%    Checks if the cell we arrived to should have beenvisited earlier
%
% In:
%======================================================================
function [OD, newt, lasttrade, drone, cell_timers, cell, lapctr, drnpathlist] = CheckDeadlines(Gs, t, cell_timers, cell, id, drone, drn, lasttrade, lapctr, drnpathlist)
    OD = 0;
    newt = t;
    
    if cell_timers(id) > Gs.Deadlines(id) %passes deadline
        if cell_timers(id) > 10*Gs.Deadlines(id)
                    disp('Error over searched: It is impossible to find a solution with these Deadlines or with this number of drones.');
                    OD = -1;
                    return;
        end
                
        OD = 1;
        disp(['Cell ', num2str(id), ' Deadline Expired with ', num2str(cell_timers(id))]);
        %naïve choice - go before the last visited cell
        % 'cb4s are pointers'
        
        %index of the cell before the last visited cell - cb4
        ind = find(drone(drn).tracker(1,:)==0,1) - 2;
        cb4 = drone(drn).tracker(3,ind) - 1;
        
        % check trade
        ct_res = CheckTrade(lasttrade, ...
            id, drone(drn).tracker(3,ind+1), ...
            drone(drn).tracker(1,ind+1), cb4+1, drn);
        lasttrade = UpdateTrades(lasttrade, drn, ...
            id, drone(drn).tracker(3,ind+1), ...
            drone(drn).tracker(1,ind+1), cb4+1);
        
        
        
        if ct_res == 0
            %IN THE CASE THAT I WANT TO PLOT THE FINAL POINT, I MIGHT NEED
            %THIS
            disp('It is impossible to find a solution with these Deadlines or with this number of drones.');
            OD = -1;
            return;
            %error('It is impossible to find a solution with these Deadlines or with this number of drones.');
            
        end
        
%         disp(['Old path for drone ', num2str(drn), ' :']);
%         disp(drone(drn).path);
        
        
        
        %change the path of the drone
        if drone(drn).tracker(3,ind+1) == length(drone(drn).path)
            drone(drn).path = [drone(drn).path(1:cb4), id, drone(drn).path(cb4+1:drone(drn).tracker(3,ind))];
            
            
        else
            id_ind = drone(drn).tracker(3,ind+1);
            drone(drn).path = [drone(drn).path(1:cb4), id, drone(drn).path((cb4+1):(id_ind-1)), drone(drn).path((id_ind+1):end)];
        end
        %check if trade made
        for kk = 1:length(drnpathlist(drn).plist)
            if length(drone(drn).path) == length(drnpathlist(drn).plist(kk).p)
                if drone(drn).path == drnpathlist(drn).plist(kk).p
                    disp('It is impossible to find a solution with these Deadlines or with this number of drones.');
                    OD = -1;
                    return;
                end
            end
        end
        
%         disp(['New path for drone ', num2str(drn), ' :']);
%         disp(drone(drn).path);
%         disp('============================================');
        
        %reset everything to time when leaves cb4 - found in tracker(4,ind)
        t_reverse = drone(drn).tracker(4,ind);
        
        
        for cc = 1:length(cell_timers)
            %reset cell.TimeLastVisit
            ind0 = find(cell(cc).TimeLastVisit(1,:) == 0,1);
            indrev = find(cell(cc).TimeLastVisit(1,:) > t_reverse,1);
            if ~isempty(indrev)
                
                lapctr(cc) = lapctr(cc) - length(indrev:(ind0-1));
                cell(cc).TimeLastVisit(:,indrev:ind0) = zeros(2,ind0-indrev+1);
            end
        end
        
        %reset cell_timers
        for cc = 1:length(cell_timers)
            if isempty(find(Gs.ObsIDs == cc,1))
                ind = find(cell(cc).TimeLastVisit(1,:) == 0,1) - 1;
                if ~isempty(ind) && ind ~= 0
                    cell_timers(cc) = t_reverse - cell(cc).TimeLastVisit(1,ind);
                else
                    cell_timers(cc) = t_reverse;
                end
            end
            
        end
        
        for dd = 1:length(drone)
            %reset drone-tracker
            indtck0 = find(drone(dd).tracker(1,:) == 0,1);
            indtckrev = find(drone(dd).tracker(4,:) > t_reverse,1);
            
            drone(dd).tracker(:,indtckrev:indtck0) = zeros(4,indtck0-indtckrev+1);
            
            %reset drone.state
            indst0 = find(drone(dd).state(1,:) == 0,1);
            indstrev = find(drone(dd).state(1,:) > t_reverse,1);
            if ~isempty(indstrev)
                drone(dd).state(:,indstrev:indst0) = zeros(2,indst0-indstrev+1);
            end
            
        end
        
        
        
    end
    %%%HERE%%
    
    if OD == 1
        newt = t_reverse;
    else
        newt = t;
    end
    
end