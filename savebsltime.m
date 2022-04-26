function savebsltime(et,size)
    fileID = fopen(['missionM',num2str(size),'_bsl'], 'a+');
    fprintf(fileID, '%f\r\n', et);
    fclose(fileID); % Close file.
end