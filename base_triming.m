%corrects the ID of the cells
function p_base = base_triming(p, obsIDs)
    obsIDs = sort(obsIDs);
    for ii = obsIDs
        for jj = 1:length(p)
            if p(jj) >= ii
                p(jj) = p(jj) + 1;
            end
        end
    end
    p_base = p;
end