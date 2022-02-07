#!/bin/bash

#PBS -N Tract_FA
#PBS -o Tract_FA.log
#PBS -e Tract_FA.err
#PBS -q default
#PBS -l walltime=10:30:00
#PBS -l nodes=1:ppn=1
#PBS -m ae

ulimit -s unlimited
module load scripts

module load FSL/5.0.8-intel-2014b-pbs
. ${FSLDIR}/etc/fslconf/fsl.sh

FSLOUTPUTTYPE=NIFTI_GZ
export FSLOUTPUTTYPE

ORIGDIR=$PBS_O_WORKDIR
WORKDIR=$VSC_SCRATCH_NODE/$PBS_JOBID
#WORKDIR=$VSC_SCRATCH_NODE/$PBS_JOBID

echo Hostname: $(hostname)
echo ORIGDIR: $ORIGDIR
echo WORKDIR: $WORKDIR

mkdir -p $ORIGDIR/Tract_FA
mkdir -p $WORKDIR/Tract_FA
cd $WORKDIR/Tract_FA
pwd

cp $ORIGDIR/subject_ID_short.txt subject_ID_short.txt

echo 'First mean tract FA then tract voxels and volume'

for i in `sed -n "${PBS_ARRAYID}p" subject_ID_short.txt`;   
do 
echo ${i}

cp -a $ORIGDIR/${i}/ $WORKDIR/Tract_FA/

mkdir -p ${i}/probtrackx/Combined_LTPJ_LAmyg
echo 'Combined_LTPJ_LAmyg'
fslmaths ${i}/probtrackx/LeftTPJ_to_leftAmyg/fdt_paths.nii.gz -add ${i}/probtrackx/LeftAmyg_to_leftTPJ/fdt_paths.nii.gz ${i}/probtrackx/Combined_LTPJ_LAmyg/LeftTPJ_LAmyg_path_raw.nii.gz
fslmaths ${i}/probtrackx/Combined_LTPJ_LAmyg/LeftTPJ_LAmyg_path_raw.nii.gz -thrP 15 ${i}/probtrackx/Combined_LTPJ_LAmyg/LeftTPJ_LAmyg_path_thr.nii.gz
fslmaths ${i}/probtrackx/Combined_LTPJ_LAmyg/LeftTPJ_LAmyg_path_thr.nii.gz -bin ${i}/probtrackx/Combined_LTPJ_LAmyg/LeftTPJ_LAmyg_path_bin.nii.gz
fslmaths ${i}/Diffusion/dtifit/dtifit_FA.nii.gz -mas ${i}/probtrackx/Combined_LTPJ_LAmyg/LeftTPJ_LAmyg_path_bin.nii.gz ${i}/probtrackx/Combined_LTPJ_LAmyg/LeftTPJ_LAmyg_path_FA.nii.gz
fslstats ${i}/probtrackx/Combined_LTPJ_LAmyg/LeftTPJ_LAmyg_path_FA.nii.gz -M                     
fslstats ${i}/probtrackx/Combined_LTPJ_LAmyg/LeftTPJ_LAmyg_path_FA.nii.gz -V 

mkdir -p ${i}/probtrackx/Combined_LTPJ_LAI
echo 'Combined_LTPJ_LAI'
fslmaths ${i}/probtrackx/LeftTPJ_to_leftAI/fdt_paths.nii.gz -add ${i}/probtrackx/LeftAI_to_leftTPJ/fdt_paths.nii.gz ${i}/probtrackx/Combined_LTPJ_LAI/LeftTPJ_LAI_path_raw.nii.gz
fslmaths ${i}/probtrackx/Combined_LTPJ_LAI/LeftTPJ_LAI_path_raw.nii.gz -thrP 15 ${i}/probtrackx/Combined_LTPJ_LAI/LeftTPJ_LAI_path_thr.nii.gz
fslmaths ${i}/probtrackx/Combined_LTPJ_LAI/LeftTPJ_LAI_path_thr.nii.gz -bin ${i}/probtrackx/Combined_LTPJ_LAI/LeftTPJ_LAI_path_bin.nii.gz
fslmaths ${i}/Diffusion/dtifit/dtifit_FA.nii.gz -mas ${i}/probtrackx/Combined_LTPJ_LAI/LeftTPJ_LAI_path_bin.nii.gz ${i}/probtrackx/Combined_LTPJ_LAI/LeftTPJ_LAI_path_FA.nii.gz
fslstats ${i}/probtrackx/Combined_LTPJ_LAI/LeftTPJ_LAI_path_FA.nii.gz -M                     
fslstats ${i}/probtrackx/Combined_LTPJ_LAI/LeftTPJ_LAI_path_FA.nii.gz -V 

mkdir -p ${i}/probtrackx/Combined_LTPJ_Prec
echo 'Combined_LTPJ_Prec'
fslmaths ${i}/probtrackx/LeftTPJ_to_precuneus/fdt_paths.nii.gz -add ${i}/probtrackx/Precuneus_to_leftTPJ/fdt_paths.nii.gz ${i}/probtrackx/Combined_LTPJ_Prec/LeftTPJ_prec_path_raw.nii.gz
fslmaths ${i}/probtrackx/Combined_LTPJ_Prec/LeftTPJ_prec_path_raw.nii.gz -thrP 15 ${i}/probtrackx/Combined_LTPJ_Prec/LeftTPJ_prec_path_thr.nii.gz
fslmaths ${i}/probtrackx/Combined_LTPJ_Prec/LeftTPJ_prec_path_thr.nii.gz -bin ${i}/probtrackx/Combined_LTPJ_Prec/LeftTPJ_prec_path_bin.nii.gz
fslmaths ${i}/Diffusion/dtifit/dtifit_FA.nii.gz -mas ${i}/probtrackx/Combined_LTPJ_Prec/LeftTPJ_prec_path_bin.nii.gz ${i}/probtrackx/Combined_LTPJ_Prec/LeftTPJ_prec_path_FA.nii.gz
fslstats ${i}/probtrackx/Combined_LTPJ_Prec/LeftTPJ_prec_path_FA.nii.gz -M                     
fslstats ${i}/probtrackx/Combined_LTPJ_Prec/LeftTPJ_prec_path_FA.nii.gz -V 

mkdir -p ${i}/probtrackx/Combined_LTPJ_dmPFC
echo 'Combined_LTPJ_dmPFC'
fslmaths ${i}/probtrackx/LeftTPJ_to_dmPFC/fdt_paths.nii.gz -add ${i}/probtrackx/dmPFC_to_leftTPJ/fdt_paths.nii.gz ${i}/probtrackx/Combined_LTPJ_dmPFC/LeftTPJ_dmPFC_path_raw.nii.gz
fslmaths ${i}/probtrackx/Combined_LTPJ_dmPFC/LeftTPJ_dmPFC_path_raw.nii.gz -thrP 15 ${i}/probtrackx/Combined_LTPJ_dmPFC/LeftTPJ_dmPFC_path_thr.nii.gz
fslmaths ${i}/probtrackx/Combined_LTPJ_dmPFC/LeftTPJ_dmPFC_path_thr.nii.gz -bin ${i}/probtrackx/Combined_LTPJ_dmPFC/LeftTPJ_dmPFC_path_bin.nii.gz
fslmaths ${i}/Diffusion/dtifit/dtifit_FA.nii.gz -mas ${i}/probtrackx/Combined_LTPJ_dmPFC/LeftTPJ_dmPFC_path_bin.nii.gz ${i}/probtrackx/Combined_LTPJ_dmPFC/LeftTPJ_dmPFC_path_FA.nii.gz
fslstats ${i}/probtrackx/Combined_LTPJ_dmPFC/LeftTPJ_dmPFC_path_FA.nii.gz -M                     
fslstats ${i}/probtrackx/Combined_LTPJ_dmPFC/LeftTPJ_dmPFC_path_FA.nii.gz -V 

mkdir -p ${i}/probtrackx/Combined_LTPJ_LTempPole
echo 'Combined_LTPJ_LTempPole'
fslmaths ${i}/probtrackx/LeftTPJ_to_lefttemppole/fdt_paths.nii.gz -add ${i}/probtrackx/Lefttemppole_to_leftTPJ/fdt_paths.nii.gz ${i}/probtrackx/Combined_LTPJ_LTempPole/LeftTPJ_LTempPole_path_raw.nii.gz
fslmaths ${i}/probtrackx/Combined_LTPJ_LTempPole/LeftTPJ_LTempPole_path_raw.nii.gz -thrP 15 ${i}/probtrackx/Combined_LTPJ_LTempPole/LeftTPJ_LTempPole_path_thr.nii.gz
fslmaths ${i}/probtrackx/Combined_LTPJ_LTempPole/LeftTPJ_LTempPole_path_thr.nii.gz -bin ${i}/probtrackx/Combined_LTPJ_LTempPole/LeftTPJ_LTempPole_path_bin.nii.gz
fslmaths ${i}/Diffusion/dtifit/dtifit_FA.nii.gz -mas ${i}/probtrackx/Combined_LTPJ_LTempPole/LeftTPJ_LTempPole_path_bin.nii.gz ${i}/probtrackx/Combined_LTPJ_LTempPole/LeftTPJ_LTempPole_path_FA.nii.gz
fslstats ${i}/probtrackx/Combined_LTPJ_LTempPole/LeftTPJ_LTempPole_path_FA.nii.gz -M                     
fslstats ${i}/probtrackx/Combined_LTPJ_LTempPole/LeftTPJ_LTempPole_path_FA.nii.gz -V 

mkdir -p ${i}/probtrackx/Combined_RTPJ_RAmyg
echo 'Combined_RTPJ_RAmyg'
fslmaths ${i}/probtrackx/RightTPJ_to_rightAmyg/fdt_paths.nii.gz -add ${i}/probtrackx/RightAmyg_to_rightTPJ/fdt_paths.nii.gz ${i}/probtrackx/Combined_RTPJ_RAmyg/RightTPJ_RAmyg_path_raw.nii.gz
fslmaths ${i}/probtrackx/Combined_RTPJ_RAmyg/RightTPJ_RAmyg_path_raw.nii.gz -thrP 15 ${i}/probtrackx/Combined_RTPJ_RAmyg/RightTPJ_RAmyg_path_thr.nii.gz
fslmaths ${i}/probtrackx/Combined_RTPJ_RAmyg/RightTPJ_RAmyg_path_thr.nii.gz -bin ${i}/probtrackx/Combined_RTPJ_RAmyg/RightTPJ_RAmyg_path_bin.nii.gz
fslmaths ${i}/Diffusion/dtifit/dtifit_FA.nii.gz -mas ${i}/probtrackx/Combined_RTPJ_RAmyg/RightTPJ_RAmyg_path_bin.nii.gz ${i}/probtrackx/Combined_RTPJ_RAmyg/RightTPJ_RAmyg_path_FA.nii.gz
fslstats ${i}/probtrackx/Combined_RTPJ_RAmyg/RightTPJ_RAmyg_path_FA.nii.gz -M                     
fslstats ${i}/probtrackx/Combined_RTPJ_RAmyg/RightTPJ_RAmyg_path_FA.nii.gz -V 

mkdir -p ${i}/probtrackx/Combined_RTPJ_RAI
echo 'Combined_RTPJ_RAI'
fslmaths ${i}/probtrackx/RightTPJ_to_rightAI/fdt_paths.nii.gz -add ${i}/probtrackx/RightAI_to_rightTPJ/fdt_paths.nii.gz ${i}/probtrackx/Combined_RTPJ_RAI/RightTPJ_RAI_path_raw.nii.gz
fslmaths ${i}/probtrackx/Combined_RTPJ_RAI/RightTPJ_RAI_path_raw.nii.gz -thrP 15 ${i}/probtrackx/Combined_RTPJ_RAI/RightTPJ_RAI_path_thr.nii.gz
fslmaths ${i}/probtrackx/Combined_RTPJ_RAI/RightTPJ_RAI_path_thr.nii.gz -bin ${i}/probtrackx/Combined_RTPJ_RAI/RightTPJ_RAI_path_bin.nii.gz
fslmaths ${i}/Diffusion/dtifit/dtifit_FA.nii.gz -mas ${i}/probtrackx/Combined_RTPJ_RAI/RightTPJ_RAI_path_bin.nii.gz ${i}/probtrackx/Combined_RTPJ_RAI/RightTPJ_RAI_path_FA.nii.gz
fslstats ${i}/probtrackx/Combined_RTPJ_RAI/RightTPJ_RAI_path_FA.nii.gz -M                     
fslstats ${i}/probtrackx/Combined_RTPJ_RAI/RightTPJ_RAI_path_FA.nii.gz -V 

mkdir -p ${i}/probtrackx/Combined_RTPJ_Prec
echo 'Combined_RTPJ_Prec'
fslmaths ${i}/probtrackx/RightTPJ_to_precuneus/fdt_paths.nii.gz -add ${i}/probtrackx/Precuneus_to_rightTPJ/fdt_paths.nii.gz ${i}/probtrackx/Combined_RTPJ_Prec/RightTPJ_prec_path_raw.nii.gz
fslmaths ${i}/probtrackx/Combined_RTPJ_Prec/RightTPJ_prec_path_raw.nii.gz -thrP 15 ${i}/probtrackx/Combined_RTPJ_Prec/RightTPJ_prec_path_thr.nii.gz
fslmaths ${i}/probtrackx/Combined_RTPJ_Prec/RightTPJ_prec_path_thr.nii.gz -bin ${i}/probtrackx/Combined_RTPJ_Prec/RightTPJ_prec_path_bin.nii.gz
fslmaths ${i}/Diffusion/dtifit/dtifit_FA.nii.gz -mas ${i}/probtrackx/Combined_RTPJ_Prec/RightTPJ_prec_path_bin.nii.gz ${i}/probtrackx/Combined_RTPJ_Prec/RightTPJ_prec_path_FA.nii.gz
fslstats ${i}/probtrackx/Combined_RTPJ_Prec/RightTPJ_prec_path_FA.nii.gz -M                     
fslstats ${i}/probtrackx/Combined_RTPJ_Prec/RightTPJ_prec_path_FA.nii.gz -V 

mkdir -p ${i}/probtrackx/Combined_RTPJ_dmPFC
echo 'Combined_RTPJ_dmPFC'
fslmaths ${i}/probtrackx/RightTPJ_to_dmPFC/fdt_paths.nii.gz -add ${i}/probtrackx/dmPFC_to_rightTPJ/fdt_paths.nii.gz ${i}/probtrackx/Combined_RTPJ_dmPFC/RightTPJ_dmPFC_path_raw.nii.gz
fslmaths ${i}/probtrackx/Combined_RTPJ_dmPFC/RightTPJ_dmPFC_path_raw.nii.gz -thrP 15 ${i}/probtrackx/Combined_RTPJ_dmPFC/RightTPJ_dmPFC_path_thr.nii.gz
fslmaths ${i}/probtrackx/Combined_RTPJ_dmPFC/RightTPJ_dmPFC_path_thr.nii.gz -bin ${i}/probtrackx/Combined_RTPJ_dmPFC/RightTPJ_dmPFC_path_bin.nii.gz
fslmaths ${i}/Diffusion/dtifit/dtifit_FA.nii.gz -mas ${i}/probtrackx/Combined_RTPJ_dmPFC/RightTPJ_dmPFC_path_bin.nii.gz ${i}/probtrackx/Combined_RTPJ_dmPFC/RightTPJ_dmPFC_path_FA.nii.gz
fslstats ${i}/probtrackx/Combined_RTPJ_dmPFC/RightTPJ_dmPFC_path_FA.nii.gz -M                     
fslstats ${i}/probtrackx/Combined_RTPJ_dmPFC/RightTPJ_dmPFC_path_FA.nii.gz -V 

mkdir -p ${i}/probtrackx/Combined_RTPJ_RTempPole
echo 'Combined_RTPJ_RTempPole'
fslmaths ${i}/probtrackx/RightTPJ_to_righttemppole/fdt_paths.nii.gz -add ${i}/probtrackx/Righttemppole_to_rightTPJ/fdt_paths.nii.gz ${i}/probtrackx/Combined_RTPJ_RTempPole/RightTPJ_RTempPole_path_raw.nii.gz
fslmaths ${i}/probtrackx/Combined_RTPJ_RTempPole/RightTPJ_RTempPole_path_raw.nii.gz -thrP 15 ${i}/probtrackx/Combined_RTPJ_RTempPole/RightTPJ_RTempPole_path_thr.nii.gz
fslmaths ${i}/probtrackx/Combined_RTPJ_RTempPole/RightTPJ_RTempPole_path_thr.nii.gz -bin ${i}/probtrackx/Combined_RTPJ_RTempPole/RightTPJ_RTempPole_path_bin.nii.gz
fslmaths ${i}/Diffusion/dtifit/dtifit_FA.nii.gz -mas ${i}/probtrackx/Combined_RTPJ_RTempPole/RightTPJ_RTempPole_path_bin.nii.gz ${i}/probtrackx/Combined_RTPJ_RTempPole/RightTPJ_RTempPole_path_FA.nii.gz
fslstats ${i}/probtrackx/Combined_RTPJ_RTempPole/RightTPJ_RTempPole_path_FA.nii.gz -M                     
fslstats ${i}/probtrackx/Combined_RTPJ_RTempPole/RightTPJ_RTempPole_path_FA.nii.gz -V

mkdir -p ${i}/probtrackx/Combined_LTPJ_RTPJ
echo 'Combined_LTPJ_RTPJ'
fslmaths ${i}/probtrackx/LeftTPJ_to_rightTPJ/fdt_paths.nii.gz -add ${i}/probtrackx/RightTPJ_to_leftTPJ/fdt_paths.nii.gz ${i}/probtrackx/Combined_LTPJ_RTPJ/LeftTPJ_RTPJ_path_raw.nii.gz
fslmaths ${i}/probtrackx/Combined_LTPJ_RTPJ/LeftTPJ_RTPJ_path_raw.nii.gz -thrP 15 ${i}/probtrackx/Combined_LTPJ_RTPJ/LeftTPJ_RTPJ_path_thr.nii.gz
fslmaths ${i}/probtrackx/Combined_LTPJ_RTPJ/LeftTPJ_RTPJ_path_thr.nii.gz -bin ${i}/probtrackx/Combined_LTPJ_RTPJ/LeftTPJ_RTPJ_path_bin.nii.gz
fslmaths ${i}/Diffusion/dtifit/dtifit_FA.nii.gz -mas ${i}/probtrackx/Combined_LTPJ_RTPJ/LeftTPJ_RTPJ_path_bin.nii.gz ${i}/probtrackx/Combined_LTPJ_RTPJ/LeftTPJ_RTPJ_path_FA.nii.gz
fslstats ${i}/probtrackx/Combined_LTPJ_RTPJ/LeftTPJ_RTPJ_path_FA.nii.gz -M                     
fslstats ${i}/probtrackx/Combined_LTPJ_RTPJ/LeftTPJ_RTPJ_path_FA.nii.gz -V 


mkdir -p $ORIGDIR/Tract_FA/${i}

cp -a  $WORKDIR/Tract_FA/${i}/probtrackx/Combined_LTPJ_LAmyg $ORIGDIR/Tract_FA/${i}/
cp -a  $WORKDIR/Tract_FA/${i}/probtrackx/Combined_LTPJ_LAI $ORIGDIR/Tract_FA/${i}/
cp -a  $WORKDIR/Tract_FA/${i}/probtrackx/Combined_LTPJ_Prec $ORIGDIR/Tract_FA/${i}/
cp -a  $WORKDIR/Tract_FA/${i}/probtrackx/Combined_LTPJ_dmPFC $ORIGDIR/Tract_FA/${i}/
cp -a  $WORKDIR/Tract_FA/${i}/probtrackx/Combined_LTPJ_LTempPole $ORIGDIR/Tract_FA/${i}/
cp -a  $WORKDIR/Tract_FA/${i}/probtrackx/Combined_LTPJ_RTPJ $ORIGDIR/Tract_FA/${i}/
cp -a  $WORKDIR/Tract_FA/${i}/probtrackx/Combined_RTPJ_RAmyg $ORIGDIR/Tract_FA/${i}/
cp -a  $WORKDIR/Tract_FA/${i}/probtrackx/Combined_RTPJ_RAI $ORIGDIR/Tract_FA/${i}/
cp -a  $WORKDIR/Tract_FA/${i}/probtrackx/Combined_RTPJ_Prec $ORIGDIR/Tract_FA/${i}/
cp -a  $WORKDIR/Tract_FA/${i}/probtrackx/Combined_RTPJ_dmPFC $ORIGDIR/Tract_FA/${i}/
cp -a  $WORKDIR/Tract_FA/${i}/probtrackx/Combined_RTPJ_RTempPole $ORIGDIR/Tract_FA/${i}/

done

rm -Rf $WORKDIR/Tract_FA
