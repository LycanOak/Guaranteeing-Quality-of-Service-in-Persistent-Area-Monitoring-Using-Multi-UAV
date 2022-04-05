%====================================================================
% converts a list of cells with certain characteristics to a bigger AoI
% CAUTION check for M = 15
% In:
%   inig - smaller graph
%   newg - current size graph
%   list - list in the smaller AoI
% Out:
%   Newlist - list in the current AoI
%====================================================================

function [Newlist] = RecalibrateCells(inig, newg, list)
 
        
    factor = newg.M/inig.M;
    newlist = zeros(1,length(list)*(factor)^2);
    
    o = 1;
    for ol = list
        bx = inig.XD(ol);
        by = inig.YD(ol);
        
        for cc = 1:(newg.M)^2
            if bx == ceil(newg.XD(cc)/factor) && ...
                    by == ceil(newg.YD(cc)/factor)
                newlist(o) = cc;
                o = o + 1;
            end
        end
             
    end
    Newlist = newlist;
end
    % M = 5  -->  [04
    %              09
    %              14]
%     o-o-o-o-o
%     o-o-o-o-o
%     o-o-o-+-o
%     o-o-o-8-o
%     o-o-o-x-o

    % M = 10 --> [07,08,17,18
    %             27,28,37,38
    %             47,48,57,58]
%     o-o-o-o-o-o-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o
%     o-o-o-o-o-o-+-+-o-o
%     o-o-o-o-o-o-+-+-o-o
%     o-o-o-o-o-o-8-8-o-o
%     o-o-o-o-o-o-8-8-o-o
%     o-o-o-o-o-o-x-x-o-o
%     o-o-o-o-o-o-x-x-o-o

    % M = 20->[013,014,015,016,033,034,035,036,053,054,055,056,073,074,075,076
    %          093,094,095,096,113,114,115,116,133,134,135,136,153,154,155,156
    %          173,174,175,176,193,194,195,196,213,214,215,216,233,234,235,236]
%     o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-+-+-+-+-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-+-+-+-+-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-+-+-+-+-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-+-+-+-+-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-8-8-8-8-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-8-8-8-8-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-8-8-8-8-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-8-8-8-8-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-x-x-x-x-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-x-x-x-x-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-x-x-x-x-o-o-o-o
%     o-o-o-o-o-o-o-o-o-o-o-o-x-x-x-x-o-o-o-o
    