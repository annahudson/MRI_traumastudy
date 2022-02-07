%-----------------------------------------------------------------------
% Job saved on 30-Jan-2017 21:02:37 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6685)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
%% Run files
run_dir = dir('iToM_localiser/swariToM_localiser*.nii');
run_names = {run_dir.name};
run_col = run_names(:);
run_files = strcat('iToM_localiser/',run_col,',1');

%%
matlabbatch{1}.spm.stats.fmri_spec.dir = {'iToM_firstlevel_localiser'};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 34;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 34;
%%
matlabbatch{1}.spm.stats.fmri_spec.sess.scans = run_files;
%%
matlabbatch{1}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {'Cons_localiser.mat'}; 
matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {'iToM_localiser/rp_iToM_localiser_0006.txt'};
matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
%%
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
