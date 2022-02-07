
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLAB script to preprocess fMRI data
% Author: Anna Hudson
% Date: 20/01/2017
% Notes: Preliminary version. This version will work for only one run at a
% time (but for all participants).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Looping through all participants

addpath /home/matlab3/Documents/Study_1_Anna/Batch_files/spm12

cd ('/home/matlab3/Documents/Study_1_Anna');
ppts = dir('MRI_nii/R_traumastudy_*');
ppts_names = {ppts.name}; % Some participants don't have a localiser task.
% ppts_localiser = [ppts_names(1:28),ppts_names(30:32),ppts_names(34:length(ppts_names))]; % Two participants did not complete the ToM localiser task
% ppts_folders = strcat('/home/matlab3/Documents/Study_1_Anna/MRI_nii/',ppts_localiser);
ppts_folders = strcat('/home/matlab3/Documents/Study_1_Anna/MRI_nii/',ppts_names);

disp('iToM_localiser')

 for i=76   % 1:length(ppts_folders)
   cd(ppts_folders{i});
   pwd

% Batch file
nrun = 1; % enter the number of runs here

jobfile = {'/home/matlab3/Documents/Study_1_Anna/Batch_files/pleasework_3_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
    for crun = 1:nrun
    end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});

% Finishing

 end