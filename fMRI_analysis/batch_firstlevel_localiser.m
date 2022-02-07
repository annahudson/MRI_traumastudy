%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLAB script for first-level analysis of fMRI data (iToM)
% Author: Anna Hudson
% Date: 30/01/2017
% Notes: Final version for the localiser. First step to be ran after 
% preprocessing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Looping through all participants
addpath /home/matlab3/Documents/Study_1_Anna/Batch_files/spm12

cd ('/home/matlab3/Documents/Study_1_Anna/MRI_nii');
ppts_dir = dir('R_traumastudy_*');
ppts_names = {ppts_dir.name}; 
ppts_all = strcat(pwd,'/',ppts_names);
% select = [1:4 6:28 30:32 34:length(ppts_all)]; % Participants 29 and 33 
% do not have a localiser task and participant 5 had something mess up with
% their scan
% ppts_run = ppts_all(select);

disp('First-level model specification: ToM localiser')

for i=76  % 1:length(ppts_all)
    cd(ppts_all{i});
    mkdir('iToM_firstlevel_localiser');
    pwd
    
% Batch file
nrun = 1; % enter the number of runs here
jobfile = {'/home/matlab3/Documents/Study_1_Anna/Batch_files/batch_firstlevel_localiser_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
    
 % Finish
end
