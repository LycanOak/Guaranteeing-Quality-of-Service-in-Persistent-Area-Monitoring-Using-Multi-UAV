function savetsptime(et,size)
    fileID = fopen(['missionM',num2str(size),'_tsp'], 'a+');
    fprintf(fileID, '%f\r\n', et);
    fclose(fileID); % Close file.
end