%===============================================================
% Gets name of the file with the AoI definition
% In: -
%
% Out:
%   name - cell containing the name of the file
%===============================================================
function name = LoadPrev()
    name = inputdlg('Insert file name:');
    while ~isfile(name)
        msgbox('File can''nt be found. Please try again.');
        name = inputdlg('Insert file name:');
    end
end