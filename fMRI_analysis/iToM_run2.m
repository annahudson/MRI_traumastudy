
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
ppts = dir('MRI_nii');
ppts_names = {ppts.name}; % Discard the first two names as these are not relevant.
ppts_list = [ppts_names(3:length(ppts_names))];
ppts_folders = strcat('/home/matlab3/Documents/Study_1_Anna/MRI_nii/',ppts_list);

 for i=76      % 1:length(ppts_folders)
   cd(ppts_folders{i});
   disp('iToM_run2')
   pwd

% Batch file
nrun = 1; % enter the number of runs here

jobfile = {'/home/matlab3/Documents/Study_1_Anna/Batch_files/pleasework_2_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
    for crun = 1:nrun
    end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});

% Finishing

 end