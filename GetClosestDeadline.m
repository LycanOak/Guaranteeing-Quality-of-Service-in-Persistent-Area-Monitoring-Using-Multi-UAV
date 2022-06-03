function cd = GetClosestDeadline(hist_info, Deadlines, Ncells)
    cd = zeros(1,Ncells);
    for ii = 1:length(hist_info)
        for jj = 1:length(hist_info(ii).info)
            if ~isempty(hist_info(ii).info(jj).TimeBtwnVisits)
                ds = Deadlines(jj)*ones(1,length(hist_info(ii).info(jj).TimeBtwnVisits));
                cd(jj) = Deadlines(jj) - min(ds - hist_info(ii).info(jj).TimeBtwnVisits);
                
                cd(jj) = cd(jj)/Deadlines(jj)*100;
                
            end
        end
    end
end