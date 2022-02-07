%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PPI ANALYSES
% Author: Anna Hudson
% Date: 23/11/2017
% Notes: Uses pre-extracted VOI masks, using batch_voiextract.m 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Setting participants and VOIs

addpath /home/matlab3/Documents/Study_1_Anna/Batch_files/spm12
addpath /home/matlab3/Documents/Study_1_Anna/Batch_files/spm12/toolbox/PPPI/

cd ('/home/matlab3/Documents/Study_1_Anna/MRI_nii');
ppts_dir = dir('R_traumastudy_*');
ppts_names = {ppts_dir.name}; 
ppts_directory = strcat(pwd,'/',ppts_names,'/iToM_firstlevel_belief');

regions_names = {'dmPFC' 'LTPJ' 'RTPJ'};
VOIs_run = strcat('VOI_',regions_names,'_final_mask.nii');

subs = strrep(ppts_directory,'/home/matlab3/Documents/Study_1_Anna/MRI_nii/R_traumastudy_','');
subs = strrep(subs,'/iToM_firstlevel_belief','');

%% PPI analysis

% Looping over all participants and all VOIs

for i=1:length(ppts_directory)
        
    for j=2:length(VOIs_run);
        cd(ppts_directory{i});
        disp(subs{i});
        disp(regions_names{j});
        try
            P.subject = subs{i};
            P.directory = ppts_directory{i}; % P.directory = pwd;
            P.VOI = VOIs_run{j};
            P.Region = regions_names{j};
            P.analysis = 'psy';
            P.method = 'cond';
            P.extract = 'eig';
            P.Tasks = {'1' 'PminAplus' 'PplusAmin' 'PminAmin' 'PplusAplus'};
            P.CompContrasts = 1;
            
            P.Contrasts(1).name = 'FB_grtr_TB';
            P.Contrasts(1).left = {'PminAplus' 'PplusAmin'};
            P.Contrasts(1).right={'PminAmin' 'PplusAplus'};
            P.Contrasts(1).MinEvents = 64; % or is this 32?
            P.Contrasts(1).STAT = 'T';
        
            save([subs{i} '_gppi_' regions_names{j} '.mat'],'P');
            
            PPPI([subs{i} '_gppi_' regions_names{j} '.mat']);
            
        catch
            disp(['Failed to process: ' subs{i} 'for VOI: ' regions_names{j}])
        end
    
    end

end
