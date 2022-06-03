function ClosestMat = SaveClosestDeadline(Gs, ClosestMat, groups, hist_info, Ndrones, nds)
    
    %get the visit (clock state) that is closest to each cell deadline
    cd = GetClosestDeadline(hist_info, Gs.Deadlines, (Gs.M)^2);
    groups = sort(unique(groups));
    for g = groups %for every class
        gind = find(groups == g);
        clt = [];
        for ii = 1:length(hist_info(g).info) % for every field of info
            if ~isempty(hist_info(g).info(ii).TimeBtwnVisits) %if the cell is part of the class
                clt = [clt, cd(ii)];
                %clt = [clt, cd(ii)/Gs.Deadlines(ii)*100];
            end
        end
        if ~isempty(clt)
            ClosestMat.closestMat(g+1,find(Ndrones ==nds,1)) = max(clt);
        end
    end
end







