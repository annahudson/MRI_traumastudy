%% NOTE TO SELF: THIS SCRIPT CAN BE RUN FOR EITHER CALCULATING THE ONSET 
% TIMES FOR BELIEF FORMATION OR FOR OUTCOME. LINES 50-54 CAN BE TOGGLED FOR
% THIS
% Make sure to change the run number, filename, and location too 
% tic
clear all
close all
clc

%% Input variables
% List of participant numbers. Here, files are named xxx-1_Ana.log and
% xxx-2_Ana.log
participant_code = {'ppt76'};
    % {'ppt1';'ppt2';'ppt3';'ppt4';'ppt5';'ppt6';'ppt7';'ppt8';'ppt9';'ppt10';'ppt11';'ppt12';'ppt13';'ppt14';'ppt15';'ppt16';'ppt17';'ppt18';'ppt19';'ppt20';'ppt21';'ppt22';'ppt23';'ppt24';'ppt25';'ppt26';'ppt27';'ppt28';'ppt29';'ppt30';'ppt31';'ppt32';'ppt33';'ppt34';'ppt35';'ppt36';'ppt37';'ppt38';'ppt39';'ppt40';'ppt41';'ppt42';'ppt43';'ppt44';'ppt45';'ppt46';'ppt47';'ppt48';'ppt49';'ppt50';'ppt51';'ppt52';'ppt53';'ppt54';'ppt55'};
% exp_code='ImpToM';
conditions={'Pmin_Aplus_Bmin', 'Pmin_Aplus_Bplus', 'Pplus_Amin_Bmin',...
    'Pplus_Amin_Bplus','Pmin_Amin_Bmin', 'Pmin_Amin_Bplus', 'Pplus_Aplus_Bmin', 'Pplus_Aplus_Bplus'};
conditions_abbrev={'Pmin_Amin', 'Pmin_Aplus', 'Pplus_Amin', 'Pplus_Aplus'};
run_number=1; % Change this

%% Path logfiles
inputdir='H:/Anna/2017/Study 2 (fMRI)/Study_2_March_2016/Data/Logfiles/ImplicitToM';
cd(inputdir);

%% Create output folder
% write_dir=strcat(inputdir,'/Onsetfiles_run2');
% if exist (strcat(write_dir),'dir')
%    rmdir (strcat(write_dir),'s')
% end
% mkdir (strcat(write_dir));

%% Create output
for i=1:size(participant_code)
    % Import and process data
    for run_n = 1:run_number   % amount of fMRI runs, 4 in total % MIGHT NEED TO CHANGE THIS
        logfilename_a = strcat(participant_code{i},'-1-1_Ana','.log');
        % logfilename_b = strcat(participant_code{i},'b-1-2_Ana','.log');
        % logfilename = [logfilename_a;logfilename_b];
        % Import the first 6 columns of the logfile (skip the rest of the Presentation header lines)        
        fid = fopen(logfilename_a,'r');
        % fid = fopen(logfilename_b,'r');
        data = textscan(fid,'%s%f%s%s%f%f%*[^\n]','headerLines', 5);
        fclose(fid);        
        % Remove the part of 'data' before the first scanner pulse (to get rid of the trial runs)
        data{1,5}(1:find(strcmp('99',data{1,4}),1,'first')-1)=[];
        data{1,4}(1:find(strcmp('99',data{1,4}),1,'first')-1)=[];    
        % get 'time0' (= time corresponding to the 5th occurence of '99' in the fourth column; 5th pulse of the scanner)
        time0=data{1,5}(find((cumsum(strcmp('99',data{1,4})))==6,1,'first'));       
        % Filter out all the relevant conditions        
        all_conditions=data{1,4}(ismember(data{1,4},conditions));
        % Get the corresponding times, subtract time0, convert to sec 
        % For belief formation:
        times=(data{1,5}(ismember(data{1,4},conditions))-time0)./1e4+4;  
        % For outcome:
        % times=(data{1,5}(ismember(data{1,4},conditions))-time0)./1e4+13.25;
        % get the times of condition1        
        Pmin_Amin_Bplus_times=times(ismember(all_conditions,conditions(strcmp(conditions, 'Pmin_Amin_Bplus')))); 
        Pmin_Amin_Bmin_times=times(ismember(all_conditions,conditions(strcmp(conditions, 'Pmin_Amin_Bmin'))));
        Pmin_Amin_total_times=[Pmin_Amin_Bplus_times; Pmin_Amin_Bmin_times];
        % sort the condition1 times from small to large
        evalstr=strcat('Pmin_Amin_',num2str(run_number),'=sort(Pmin_Amin_total_times);'); % ???
        eval(evalstr);        
        % get the times of condition2        
        Pmin_Aplus_Bplus_times=times(ismember(all_conditions,conditions(strcmp(conditions, 'Pmin_Aplus_Bplus'))));
        Pmin_Aplus_Bmin_times=times(ismember(all_conditions,conditions(strcmp(conditions, 'Pmin_Aplus_Bmin'))));
        Pmin_Aplus_total_times=[Pmin_Aplus_Bplus_times; Pmin_Aplus_Bmin_times];
        % sort the condition2 times from small to large
        evalstr=strcat('Pmin_Aplus_',num2str(run_number),'=sort(Pmin_Aplus_total_times);'); 
        eval(evalstr);        
        % get the times of condition3        
        Pplus_Amin_Bplus_times=times(ismember(all_conditions,conditions(strcmp(conditions, 'Pplus_Amin_Bplus'))));  
        Pplus_Amin_Bmin_times=times(ismember(all_conditions,conditions(strcmp(conditions, 'Pplus_Amin_Bmin')))); 
        Pplus_Amin_total_times=[Pplus_Amin_Bplus_times; Pplus_Amin_Bmin_times];
        % sort the condition3 times from small to large
        evalstr=strcat('Pplus_Amin_',num2str(run_number),'=sort(Pplus_Amin_total_times);');
        eval(evalstr);                
        % get the times of condition4        
        Pplus_Aplus_Bplus_times=times(ismember(all_conditions,conditions(strcmp(conditions, 'Pplus_Aplus_Bplus'))));
        Pplus_Aplus_Bmin_times=times(ismember(all_conditions,conditions(strcmp(conditions, 'Pplus_Aplus_Bmin'))));
        Pplus_Aplus_total_times=[Pplus_Aplus_Bplus_times; Pplus_Aplus_Bmin_times];
        % sort the condition4 times from small to large
        evalstr=strcat('Pplus_Aplus_',num2str(run_number),'=sort(Pplus_Aplus_total_times);');
        eval(evalstr);                
    end  
    
    % write .txt output    
    filename=strcat('Onset_',participant_code{i},'.txt');
    fid = fopen(filename, 'wt');
    
    for run_n=run_number        
        for ii = 1:size(conditions_abbrev,2)           
            %fprintf(fid, strcat('s', participant_code{i}, '_',num2str(run_n),'\t'));     %in total 4 runs needed
            condname=strcat(conditions_abbrev{ii},'_',num2str(run_number),'\t');
            fprintf(fid, condname);
            fprintf(fid, '%5.2f\t',eval(strcat(conditions_abbrev{ii},'_',num2str(run_number))));
            fprintf(fid, '\n');                    
        end
    end
    
    fclose(fid);
    
end


%toc
