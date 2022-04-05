%================================================================
% Asks if the mission to be ran is based on previous work
% In: -
%
% Out:
%   LorN - 1 if load, 0 if to create new mission
%================================================================

function LorN = LoadOrNew()
    answer = questdlg('Do you want to load past AoI(s)?', ...
        'Start', ...
        'Yes','No','No');
        
    switch answer
        case 'Yes'
            LorN = 1;
        case 'No'
            LorN = 0;
    end
end