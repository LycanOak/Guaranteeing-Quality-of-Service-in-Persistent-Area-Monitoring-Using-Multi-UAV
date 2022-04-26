% READ TSPvsBSL times
classdef readTSPvsBSL
    methods(Static)
        function C = readfile(fname)
            fileID = fopen(fname, 'r');
            C = textscan(fileID,'%.5f',600);
            C = cell2mat(C);
            C = C(1:2:end);
            fclose(fileID); % Close file.
        end
        
        function [C,C_median] = GetRunTimes()
            
            % read all files
            
            Ms = [5,10,15,20];
            i = 1;
            for M = Ms
                fname1 = ['missionM',num2str(M),'_tsp'];              
                C(i).C1 = readTSPvsBSL.readfile(fname1);
                C_median(i).C1 = rmoutliers(C(i).C1,'median');
                msize = numel(C_median(i).C1);
                sel100(i).C1 = C_median(i).C1(randperm(msize, 100));
                sel100(i).mean1 = mean(sel100(i).C1);
                sel100(i).std1 = std(sel100(i).C1);
                i = i + 1;
            end
            
            i = 1;
            for M = Ms
                fname2 = ['missionM',num2str(M),'_bsl'];
                
                C(i).C2 = readTSPvsBSL.readfile(fname2);
                C_median(i).C2 = rmoutliers(C(i).C2,'median');
                msize = numel(C_median(i).C2);
                sel100(i).C2 = C_median(i).C2(randperm(msize, 100));
                sel100(i).mean2 = mean(sel100(i).C2);
                sel100(i).std2 = std(sel100(i).C2);
                i = i + 1;
            end
            
            
            %select only 100
            sz = 100;
            
%             sc = figure;
%             hs = figure;
            
            for i = 1:4

%                 %figure(sc);
%                 %hold on;
%                 figure();
%                 scatter(1:sz,C_median(i).C1(1:sz)','filled', 'MarkerFaceColor', [0 0.4470 0.7410]);
%                 title(['TSP Path Generation for M = ',num2str(Ms(i))],'FontSize',18);
%                 lgd = legend(['M = ',num2str(Ms(i))]);
%                 lgd.FontSize = 16;
%                 xlabel('Runs','FontSize',18);
%                 ylabel('Computing Time [s]','FontSize',18);
%                 
%                 %figure(sc);
%                 %hold on;
%                 figure();
%                 scatter(1:sz,C_median(i).C2(1:sz)','filled','MarkerFaceColor', [0.8500 0.3250 0.0980]);
%                 title(['Baseline Path Generation for M = ',num2str(Ms(i))],'FontSize',18);
%                 lgd = legend(['M = ',num2str(Ms(i))]);
%                 lgd.FontSize = 16;
%                 xlabel('Runs','FontSize',18);
%                 ylabel('Computing Time [s]','FontSize',18);
                
                fonttitlelabels = 44;
                fontlgd = 36;
                fontticks = 32;
                formatSpec = '%.2e';
                
                %figure(hs);
                %hold on;
                hs1 = figure();
                h1 = histogram(sel100(i).C1');
                h1.FaceColor = [0 0.4470 0.7410];
                title(['TSP Path Generation M = ',num2str(Ms(i))],'FontSize', fonttitlelabels);
                ylabel('Runs','FontSize',fonttitlelabels);
                xlabel('Computing Time [s]','FontSize',fonttitlelabels);
                
                xl = xline(sel100(i).mean1,'-.', ...
                    'FontSize', fonttitlelabels);
                xl.LabelVerticalAlignment = 'middle';
                xl.LabelHorizontalAlignment = 'center';
                xl.Color = [0 153/255 0];
                xl.LineWidth = 4;
                
                xl = xline(sel100(i).mean1-sel100(i).std1,'-.', ...
                    'FontSize', fonttitlelabels);
                xl.LabelVerticalAlignment = 'middle';
                xl.LabelHorizontalAlignment = 'center';
                xl.Color = [204/255 0 102/255];
                xl.LineWidth = 4;
                
                xl = xline(sel100(i).mean1+sel100(i).std1,'-.', ...
                    'FontSize', fonttitlelabels);
                xl.LabelVerticalAlignment = 'middle';
                xl.LabelHorizontalAlignment = 'center';
                xl.Color = [204/255 0 102/255];
                xl.LineWidth = 4;
                
                lgd = legend( ...
                    ['M = ',num2str(Ms(i))], ...
                    ['\mu = ',num2str(sel100(i).mean1, formatSpec)], ...
                    ['\sigma = ',num2str(sel100(i).std1, formatSpec)]);
                lgd.FontSize = fontlgd;
                tight();
                set(hs1, 'Position',  [100, 100, 1500, 1400]);
                set(gca,'FontSize',fontticks);
                filename = ['tsp_path_genM',num2str(Ms(i)),'.png'];
                saveas(hs1,filename);
                
                %figure(hs);
                %hold on;
                hs2 = figure();
                h1 = histogram(sel100(i).C2');
                h1.FaceColor = [0.8500 0.3250 0.0980];
                title(['Baseline Path Generation M = ',num2str(Ms(i))],'FontSize', fonttitlelabels);
                ylabel('Runs','FontSize',fonttitlelabels);
                xlabel('Computing Time [s]','FontSize',fonttitlelabels);
                
                xl = xline(sel100(i).mean2,'-.', ...
                    'FontSize', fonttitlelabels);
                xl.LabelVerticalAlignment = 'middle';
                xl.LabelHorizontalAlignment = 'center';
                xl.Color = [0 153/255 0];
                xl.LineWidth = 4;
                
                xl = xline(sel100(i).mean2-sel100(i).std2,'-.', ...
                    'FontSize', fonttitlelabels);
                xl.LabelVerticalAlignment = 'middle';
                xl.LabelHorizontalAlignment = 'center';
                xl.Color = [204/255 0 102/255];
                xl.LineWidth = 4;
                
                xl = xline(sel100(i).mean2+sel100(i).std2,'-.', ...
                    'FontSize', fonttitlelabels);
                xl.LabelVerticalAlignment = 'middle';
                xl.LabelHorizontalAlignment = 'center';
                xl.Color = [204/255 0 102/255];
                xl.LineWidth = 4;
                
                lgd = legend( ...
                    ['M = ',num2str(Ms(i))], ...
                    ['\mu = ',num2str(sel100(i).mean2, formatSpec)], ...
                    ['\sigma = ',num2str(sel100(i).std2, formatSpec)]);
                lgd.FontSize = fontlgd;
                tight();
                set(hs2, 'Position',  [100, 100, 1500, 1400]);
                set(gca,'FontSize',fontticks);
                filename = ['bsl_path_genM',num2str(Ms(i)),'.png'];
                saveas(hs2,filename);
                
            end
            
%            figure(sc);
%            title('Scatter M');
%            legend(['M = ',num2str(Ms(1))], ['M = ',num2str(Ms(2))], ['M = ',num2str(Ms(3))], ['M = ',num2str(Ms(4))]);
%            
%            figure(hs);
%            title('Histogram');
%            legend(['M = ',num2str(Ms(1))], ['M = ',num2str(Ms(2))], ['M = ',num2str(Ms(3))], ['M = ',num2str(Ms(4))]);
           
            
        end
    end
end