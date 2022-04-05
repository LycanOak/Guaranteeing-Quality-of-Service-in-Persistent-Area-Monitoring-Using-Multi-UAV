%====================================================================
%   Gets the time passed between consecutive visitations of a cell
%
% In:
%   cell - info on one cell
%   t_sensing - time spent to visit a cell
%
% Out:
%   res - array of time spent between each consecutive visitations 
%           of a cell 
%====================================================================
function Tbtween = GetTimeBetweenVisitsCell(cell, t_sensing)
    
    
    ind = find(cell.TimeLastVisit(1,:)==0,1);
    Tbtween = zeros(1,ind-2);
    
    for a = 1:(ind-2)
        b = a + 1;
        
        Tbtween(a) = cell.TimeLastVisit(1,b) - cell.TimeLastVisit(1,a) ...
                        - t_sensing;
                    
    end
end