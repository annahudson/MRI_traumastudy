%-----------------------------------------------------------------------
% Job saved on 31-Jan-2017 12:02:53 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6685)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
%% INDEPENDENT SAMPLES T-TEST: GROUP ANALYSIS
%%
cd ('/home/matlab3/Documents/Study_1_Anna/MRI_nii');
ppts_dir = dir('R_traumastudy_*');
ppts_names = {ppts_dir.name}; 
scan_files_row = strcat(pwd,'/',ppts_names,'/iToM_firstlevel_belief/con_0001.nii,1');
% scan_files_row = strcat(pwd,'/',ppts_names,'/iToM_firstlevel_localiser/con_0001.nii,1');
scan_files = scan_files_row(:);
% controls = [1,2,6,8,9,10,11,14,41,46,48,49,50,53:56,59:62,64,65,67,68,70,71,73,74,75,76]; % Whole sample
% controls = [1,2,6,8,9,10,11,14,41,46,48,49,50,53:56,59:62,64,65,67,70,71,73,74,75,76];
% % For TomLoc
% controls = [1,2,6,8,9,10,14,48,50,54,55,56,59,60,61,64,65,68,70,71,73,74,75,76]; % No psychiatric disorders
% controls = [1,2,6,8,9,10,11,14,41,46,48,49,54:56,59:62,64,65,67,68,70,71,73,74,75,76]; % No psych meds
controls = [1,2,6,8,9,10,11,14,48,49,50,53:56,59:62,64,65,67,68,70,71,73,74,75,76]; % No alcohol/substance dependence/abuse
trauma = [7,13,15,17:26,28:40,42,43,51,57,58,63,66,69,72]; % whole sample
% trauma = [7,13,15,17:26,28,30:32,34:40,42,43,51,57,58,63,66,69,72]; % For
% TomLoc
% trauma = [7,13,15,17,20,21,23,25,28,29,31:36,38:40,42,51,57,58,63,66,69,72]; % Without PTSD sufferers
% trauma = [7,13,15,17,18,21,22,23,25,26,28,29,30,31,32,33,34,35,36,37,38,40,43,51,63,66,69,72]; % no psych meds
% trauma = [7,13,15,18,19,20,21,22,23,24,25,28,29,30,31,32,33,34,35,36,37,38,39,42,43,57,66,69,72]; % CSA
% trauma = [15,17,18,19,20,22,23,24,25,26,28,29,30,32,33,35,36,37,38,40,51,57,58,66,69,72]; % CPA
% trauma = [17,18,19,20,24,25,26,28,30,31,33,34,36,37,40,42,57,58,63,66,69]; % CEA
% ppt27 is excluded due to being a bit old;
% ppts 29, 33 and 68 don't have localiser tasks
scan_files_controls = scan_files(controls,1);
scan_files_trauma = scan_files(trauma,1);
%%
% MUST REMEMBER TO CHANGE DIRECTORY!!!
matlabbatch{1}.spm.stats.factorial_design.dir = {'/home/matlab3/Documents/Study_1_Anna/SecondLevelfMRI/ImpToM_noalcdep_31.10.17'};
matlabbatch{1}.spm.stats.factorial_design.des.t2.scans1 = scan_files_controls;
matlabbatch{1}.spm.stats.factorial_design.des.t2.scans2 = scan_files_trauma;
matlabbatch{1}.spm.stats.factorial_design.des.t2.dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.t2.variance = 1;
matlabbatch{1}.spm.stats.factorial_design.des.t2.gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.t2.ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov.files = {'/home/matlab3/Documents/Study_1_Anna/SecondLevelfMRI/Covariates_imptom_noalcdep_31.10.17.mat'};
matlabbatch{1}.spm.stats.factorial_design.multi_cov.iCFI = 2;
matlabbatch{1}.spm.stats.factorial_design.multi_cov.iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1; % Should maybe change back to 1
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
