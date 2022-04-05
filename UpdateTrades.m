%======================================================================
%   Updates the last trade made
% In:
%   lasttrade - struct
%   drn - drone under evaluation
%   cid, cb4id - id of cells
%   cind, cb4ind - indexes of cells
% Out:
%   Lasttrade - struct
%======================================================================
function Lasttrade = UpdateTrades(lasttrade,drn, cid,cind,cb4id,cb4ind)

    lasttrade.id(1,drn) = cid;
    lasttrade.id(2,drn) = cb4id;
    
    lasttrade.ind(1,drn) = cind;
    lasttrade.ind(2,drn) = cb4ind;
     
    Lasttrade = lasttrade;
end