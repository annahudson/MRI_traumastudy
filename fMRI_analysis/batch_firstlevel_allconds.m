%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLAB script for first-level analysis of fMRI data (iToM)
% Author: Anna Hudson
% Date: 02/02/2017
% Notes: First-level model specification including all 4 conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Looping through all participants
addpath /home/matlab3/Documents/Study_1_Anna/Batch_files/spm12

cd ('/home/matlab3/Documents/Study_1_Anna/MRI_nii');
ppts_dir = dir('R_traumastudy_*');
ppts_names = {ppts_dir.name}; 
ppts_run = strcat(pwd,'/',ppts_names);

disp('First-level model specification: implicit ToM')

for i=1  % 1:length(ppts_run)
    cd(ppts_run{i});
    mkdir('iToM_firstlevel_belief');
    pwd
    
% Batch file
nrun = 1; % enter the number of runs here
jobfile = {'/home/matlab3/Documents/Study_1_Anna/Batch_files/batch_firstlevel_allconds_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});

x = strrep(pwd,'/home/matlab3/Documents/Study_1_Anna/MRI_nii/R_traumastudy_','');
display(['Done with subject ', x, ': ', num2str(i), ' of ', num2str(length(i))]);
    
 % Finish
end
