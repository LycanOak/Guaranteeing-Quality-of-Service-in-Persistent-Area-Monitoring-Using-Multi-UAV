function path = HamilIgnoreObs(p, obsIDs)
    ii = 1;
    while ii <= length(p)
        if find(obsIDs == p(ii))
            if ii == 1
                p = p(2:end);
            else
                if ii == length(p)
                    p = p(1:ii-1);
                else
                    p = [p(1:ii-1),p(ii+1:end)];
                end
                
            end
        else
            ii = ii + 1;
        end
    end
    path = p;
end