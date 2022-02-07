%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLAB script for VOI extraction
% Author: Anna Hudson
% Date: 10/11/2017
% Notes: Currently set to use for iToM but easily adapted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Looping through all participants
addpath /home/matlab3/Documents/Study_1_Anna/Batch_files/spm12

cd ('/home/matlab3/Documents/Study_1_Anna/MRI_nii');
ppts_dir = dir('R_traumastudy_*');
ppts_names = {ppts_dir.name}; 
ppts_run = strcat(pwd,'/',ppts_names);

disp('VOI extraction')

for i=1:length(ppts_run)
    cd(ppts_run{i});
    pwd

% Batch file
nrun = 1; % enter the number of runs here
jobfile = {'/home/matlab3/Documents/Study_1_Anna/Batch_files/batch_voiextract_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});

x = strrep(pwd,'/home/matlab3/Documents/Study_1_Anna/MRI_nii/R_traumastudy_','');
display(['Done with subject ', x, ': ', num2str(i), ' of ', num2str(length(ppts_run))]);

% Finish
end
