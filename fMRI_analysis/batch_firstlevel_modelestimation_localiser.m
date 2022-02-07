%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLAB script to estimate first level models
% Author: Anna Hudson
% Date: 27/01/2017
% Notes: To loop over all participants. Must be ran after first-level
% analysis but before contrasts and second-level analysis. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Looping over all participants
addpath /home/matlab3/Documents/Study_1_Anna/Batch_files/spm12

cd ('/home/matlab3/Documents/Study_1_Anna/MRI_nii');
ppts_dir = dir('R_traumastudy_*');
ppts_names = {ppts_dir.name}; 
% ppts_all = strcat(pwd,'/',ppts_names,'/iToM_firstlevel_belief');
ppts_all = strcat(pwd,'/',ppts_names,'/iToM_firstlevel_localiser');

disp('First-level model estimation: ToM localiser')

for i=76  % 1:length(ppts_all)
    cd(ppts_all{i});
    pwd
    
% Batch file
    nrun = 1; % enter the number of runs here
    jobfile = {'/home/matlab3/Documents/Study_1_Anna/Batch_files/batch_firstlevel_modelestimation_job.m'};
    jobs = repmat(jobfile, 1, nrun);
    inputs = cell(0, nrun);
    for crun = 1:nrun
    end
    spm('defaults', 'FMRI');
    spm_jobman('run', jobs, inputs{:});
    
end
