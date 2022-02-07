%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLAB script for second level models
% Author: Anna Hudson
% Date: 31/01/2017
% Notes: Ran after model estimation and contrast manager of first-level 
% analysis. Next: model estimation and contrast manager of second-level. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 
addpath /home/matlab3/Documents/Study_1_Anna/Batch_files/spm12

cd ('/home/matlab3/Documents/Study_1_Anna/SecondLevelfMRI');
mkdir('ImpToM_noalcdep_31.10.17'); % Change depending on which model you're making
cd ('/home/matlab3/Documents/Study_1_Anna/');
  
% Batch file
nrun = 1; % enter the number of runs here

% Comparing traumatised to non-traumatised participants
jobfile = {'/home/matlab3/Documents/Study_1_Anna/Batch_files/batch_secondlevel_job.m'};
% jobfile = {'/home/matlab3/Documents/Study_1_Anna/Batch_files/batch_secondlevel_DTI_job.m'}; % Stuff for DTI
% Global analysis (one sample t-test: all participants, traumatised only,
% controls only...)
% jobfile = {'/home/matlab3/Documents/Study_1_Anna/Batch_files/batch_secondlevel_job2.m'};

jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
