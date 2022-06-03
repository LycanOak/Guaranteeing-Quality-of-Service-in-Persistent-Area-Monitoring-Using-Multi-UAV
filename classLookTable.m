class 

function looktab = classLookTable(defD)
    looktab = zeros(6,2);
    
    looktab(1,:) = [defD+1,Inf];
    x = defD/5;
    for i = 2:6
        looktab(i,:) = [defD-(i-1)*x+1,defD-(i-2)*x];
    end
end