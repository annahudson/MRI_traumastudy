%-----------------------------------------------------------------------
% Job saved on 30-Jan-2017 21:02:37 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6685)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
%% Run files
run1_dir = dir('iToM_run1/swariToM_run1*.nii');
run1_names = {run1_dir.name};
run1_col = run1_names(:);
run1_files = strcat('iToM_run1/',run1_col,',1');
run2_dir = dir('iToM_run2/swariToM_run2*.nii');
run2_names = {run2_dir.name};
run2_col = run2_names(:);
run2_files = strcat('iToM_run2/',run2_col,',1');
    
% We treat Bplus and Bmin as the same condition when we are looking at
% belief formation
%%
matlabbatch{1}.spm.stats.fmri_spec.dir = {'iToM_firstlevel_belief'};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 34;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 34;
%%
matlabbatch{1}.spm.stats.fmri_spec.sess(1).scans = run1_files;
%%
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi = {'Cons_run1_all.mat'};
matlabbatch{1}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi_reg = {'iToM_run1/rp_iToM_run1_0006.txt'};
matlabbatch{1}.spm.stats.fmri_spec.sess(1).hpf = 128;
%%
matlabbatch{1}.spm.stats.fmri_spec.sess(2).scans = run2_files;
%%
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(2).multi = {'Cons_run2_all.mat'};
matlabbatch{1}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(2).multi_reg = {'iToM_run2/rp_iToM_run2_0006.txt'};
matlabbatch{1}.spm.stats.fmri_spec.sess(2).hpf = 128;
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
