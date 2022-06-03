classdef Classes
    methods(Static)
        function looktab = LookTable(defD)
            looktab = zeros(6,2);
            
            looktab(1,:) = [defD+1,Inf];
            x = defD/5;
            for i = 2:6
                looktab(i,:) = [defD-(i-1)*x+1,defD-(i-2)*x];
            end
        end
        
        function class = WhatClass(looktab, D)
            class = -1;
            for i = 1:6
                if D >= looktab(i,1) && D <= looktab(i,2)
                    class = i-1;
                    break;
                end
            end
            if class == -1
                msg = 'Error: There is at leat one Cell with Deadline lower than 1';
                error(msg)
            end
        end
    end
end