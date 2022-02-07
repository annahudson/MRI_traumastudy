%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLAB script for first-level contrasts
% Author: Anna Hudson
% Date: 02/02/2017
% Notes: To loop over all participants. Must be ran after first-level model
% estimation and before second-level analysis. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Looping over all participants
addpath /home/matlab3/Documents/Study_1_Anna/Batch_files/spm12

cd ('/home/matlab3/Documents/Study_1_Anna/MRI_nii');
ppts_dir = dir('R_traumastudy_*');
ppts_names = {ppts_dir.name}; 
ppts_all = strcat(pwd,'/',ppts_names,'/iToM_firstlevel_belief');

disp('First-level contrasts: implicit ToM')

for i=1  % 20:length(ppts_all)
    cd(ppts_all{i});
    pwd
    
% Batch file
    nrun = 1; % enter the number of runs here
    jobfile = {'/home/matlab3/Documents/Study_1_Anna/Batch_files/batch_firstlevel_contrasts_allcons_job.m'};
    jobs = repmat(jobfile, 1, nrun);
    inputs = cell(0, nrun);
    for crun = 1:nrun
    end
    spm('defaults', 'FMRI');
    spm_jobman('run', jobs, inputs{:});

% Finish
end