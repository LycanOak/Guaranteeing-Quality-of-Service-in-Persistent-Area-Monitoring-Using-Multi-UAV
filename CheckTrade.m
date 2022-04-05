%===============================================================
%   Function to detect repeted trades
%
% In:
%   lasttrade - struct with info on the last trades of each drones
%   a, b - id of cells
%   ai, bi - indexes of cells
%   drn - drone to be evaluated
% Out:
%   result - if it's a repeated trade or not
%===============================================================
function result = CheckTrade(lasttrade, a, ai, b, bi, drn)
    result = 1;
    
    aai = find(lasttrade.ind(:,drn)' == ai,1);
    if ~isempty(aai)
        bbi = find(lasttrade.ind(:,drn)' == bi,1);
        if ~isempty(bbi)
            if lasttrade.id(aai,drn) == b && lasttrade.id(bbi,drn) == a
                result = 0;
                disp('repeated trade');
            end
        end
    end
        
end