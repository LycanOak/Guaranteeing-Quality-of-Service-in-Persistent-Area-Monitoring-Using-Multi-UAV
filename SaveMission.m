%=========================================================
% Save some information on the mission on a text file
% TO BE MODIFIED
%=========================================================
function SaveMission(size, Nobs, Nspec, D, SD, Ndrones)
    fileID = fopen(['missionM',num2str(size)], 'a'); % Open and create file in text writing mode.
% Write the content to the log text file.
fprintf(fileID, ' =======================================\r\n');
fprintf(fileID, '||          Mission Report            ||\r\n');
fprintf(fileID, ' =======================================\r\n');
time = datestr(clock,'mm/dd HH:MM:SS');
fprintf(fileID, '%14s\n',time);
fprintf(fileID, 'M = %d\n', size);
fprintf(fileID, '# drones = %d\n',Ndrones);
fprintf(fileID, '# Obstacles = %d\r\n', Nobs); 
fprintf(fileID, '# Special Cells = %d\r\n', Nspec); 
fprintf(fileID, 'Normal deadline = %d\r\n', D);
fprintf(fileID, 'Special deadline = %d\r\n', SD);
fclose(fileID); % Close file.
end
