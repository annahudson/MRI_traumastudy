%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PPI ANALYSES
% Author: Anna Hudson
% Date: 23/11/2017
% Notes: Uses pre-extracted VOI masks, using batch_voiextract.m 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Setting participants and VOIs

addpath /home/sven/spm8
addpath /home/sven/spm8/toolbox/pppi/   % This lets the script know where to find "sub"scripts

clear

cd ('/home/sven/Documents/TSXarousal/second_level_analysis/');
groups = {'men' 'transmen' 'transwomen' 'women'}; 
groups_loc = strcat(pwd,'/',groups,'/');
ppts_directory = [];

for g=1:length(groups_loc)
    cd (groups_loc{g});
    ppts_dir = dir('s*');
    ppts_names = {ppts_dir.name};
    ppts_names2 = strcat(pwd,'/',ppts_names);
    ppts_directory = [ppts_directory ppts_names2];
end    

regions_names = {'caudate_head' 'L_A_INS' 'R_P_INS'};
VOIs_run = strcat('/home/sven/Documents/TSXarousal/second_level_analysis/',regions_names,'_mask.nii');

subs = strrep(ppts_directory,'/home/sven/Documents/TSXarousal/second_level_analysis/','');
subs = strrep(subs,'/','_');

%% PPI analysis

% Looping over all participants and all VOIs

for i=1%:length(ppts_directory) % This first loop wil go over all the given PARTICIPANTS
        
    for j=1%:length(VOIs_run); % This second loop will go over all three ROIs
        
        cd(ppts_directory{i});
        sub_dir = dir('*arousal*');
        folder_name = {sub_dir.name};
        folder = strcat(pwd,'/',folder_name);
        cd(folder{1})
        
        disp(subs{i});
        disp(regions_names{j});
        try
            P.subject = subs{i}; % This is the subject code, gPPI uses it for the output
            P.directory = folder{1}; % Where gPPI can find the information it needs for the PPI analysis
            P.VOI = VOIs_run{j}; % Which VOI gPPI is extracting
            P.Region = regions_names{j}; % name of the region, used for the folder it puts the results in
            P.analysis = 'psy'; % Psychophysiological interactions
            P.method = 'cond';
            P.extract = 'eig'; % Extracts eigenvariates
            P.Tasks = {'1' 'erotic' 'neutral'}; % names of the conditions of the task we're investigating
            P.CompContrasts = 1;
            
            P.Contrasts(1).name = 'erotic_grtr_neutral'; % Erotic > neutral
            P.Contrasts(1).left = {'erotic'};
            P.Contrasts(1).right={'neutral'};
            P.Contrasts(1).MinEvents = 10; % ????
            P.Contrasts(1).STAT = 'T';
        
            save([subs{i} '_gppi_' regions_names{j} '.mat'],'P');
            
            PPPI([subs{i} '_gppi_' regions_names{j} '.mat']);
            
        catch
            disp(['Failed to process: ' subs{i} 'for VOI: ' regions_names{j}])
        end
    
    end

end
