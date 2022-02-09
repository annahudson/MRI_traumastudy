DESCRIPTION - 22/03/2017
AUTHOR: ANNA HUDSON

Order and description of MATLAB (.m) scripts: 

Preparation:

1)  process_onsetfile_*_Ana.m
	Script to create text files of onset times for each trial by condition

2)  onset_*.m
	Script to create .mat files of trial onsets, durations, and condition names to be used in first-level model specification

3) rename_*.sh
	Also included in this folder are two bash scripts which can be used via a Linux terminal to change the names of folders and files to be uniform and consistent

Preprocessing:

1)  preprocessingruns.m
	Script to run the three scripts mentioned below in a) and b)
 a) iToM_run1.m / iToM_run2.m (job files: preprocess_1_job.m / preprocess_2_job.m)
	These scripts preprocess the implicit ToM task scans (run 1 and run 2)
 b) iToM_run3.m (job files: preprocess_3_job.m)
	This script preprocesses the ToM localiser scans (one run)

GLM model:

1)  batch_firstlevel_allconds.m
	Script to perform first-level model specification on implicit ToM task using ALL 4 CONDITIONS
    batch_firstlevel_localiser.m
	Script to perform first-level model specification on ToM localiser
    batch_firstlevel_outcomes.m 
	Script to perform first-level model specification on outcome phase of implicit ToM task

2)  batch_firstlevel_modelestimation.m
	Script to perform first-level model estimation. Can be adapted for both implicit ToM and ToM localiser

3)  batch_firstlevel_contrasts_allcons.m
	Script to perform first-level contrasts for implicit ToM
    batch_firstlevel_contrasts_localiser.m
	Script to perform first-level contrasts for ToM localiser

4)  batch_secondlevel.m
	Script to perform second-level model specification. Can be adapted for implicit ToM and ToM localiser, one sample t-test versus independent t-tests

5)  There are no scripts to run second-level model estimation and contrasts as I always do this in SPM by hand
