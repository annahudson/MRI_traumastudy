#!/bin/bash

#PBS -N probtrackx_native
#PBS -q default
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=all
#PBS -m ae

ulimit -s unlimited
module load scripts

#module load parallel/20130122-intel-2014b
#module load FSL/5.0.8-intel-2014b-pbs
module load FSL
module load parallel
. ${FSLDIR}/etc/fslconf/fsl.sh

FSLOUTPUTTYPE=NIFTI_GZ
export FSLOUTPUTTYPE

ORIGDIR=$PBS_O_WORKDIR
WORKDIR=$VSC_SCRATCH_NODE/$PBS_JOBID
#WORKDIR=$VSC_SCRATCH_NODE/$PBS_JOBID

echo Hostname: $(hostname)
echo ORIGDIR: $ORIGDIR
echo WORKDIR: $WORKDIR

mkdir -p $WORKDIR/probtrackx
cd $WORKDIR/probtrackx/
pwd

cp $ORIGDIR/subject_test.txt $WORKDIR/probtrackx/subject_test.txt

for i in `sed -n "${PBS_ARRAYID}p" subject_test.txt`;
do
echo ${i}

cp -a  $ORIGDIR/${i}/ $WORKDIR/probtrackx/
pwd
echo 'done copying files'

mkdir -p ${i}/probtrackx

sem -j+0 probtrackx2 -x ${i}/IndivMasks/${i}_leftTPJ_dif.nii.gz -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --waypoints=${i}/IndivMasks/${i}_rightTPJ_dif.nii.gz --stop=${i}/IndivMasks/${i}_rightTPJ_dif.nii.gz --forcedir --opd -s ${i}/Diffusion.bedpostX/merged -m ${i}/Diffusion.bedpostX/nodif_brain_mask --dir=${i}/probtrackx/LeftTPJ_to_rightTPJ --waycond=AND;
sem -j+0 probtrackx2 -x ${i}/IndivMasks/${i}_leftTPJ_dif.nii.gz -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --waypoints=${i}/IndivMasks/${i}_leftAI_dif.nii.gz --stop=${i}/IndivMasks/${i}_leftAI_dif.nii.gz --forcedir --opd -s ${i}/Diffusion.bedpostX/merged -m ${i}/Diffusion.bedpostX/nodif_brain_mask --dir=${i}/probtrackx/LeftTPJ_to_leftAI --waycond=AND;
sem -j+0 probtrackx2 -x ${i}/IndivMasks/${i}_leftTPJ_dif.nii.gz -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --waypoints=${i}/IndivMasks/${i}_rightAI_dif.nii.gz --stop=${i}/IndivMasks/${i}_rightAI_dif.nii.gz --forcedir --opd -s ${i}/Diffusion.bedpostX/merged -m ${i}/Diffusion.bedpostX/nodif_brain_mask --dir=${i}/probtrackx/LeftTPJ_to_rightAI --waycond=AND;
sem -j+0 probtrackx2 -x ${i}/IndivMasks/${i}_leftTPJ_dif.nii.gz -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --waypoints=${i}/IndivMasks/${i}_precuneus_dif.nii.gz --stop=${i}/IndivMasks/${i}_precuneus_dif.nii.gz --forcedir --opd -s ${i}/Diffusion.bedpostX/merged -m ${i}/Diffusion.bedpostX/nodif_brain_mask --dir=${i}/probtrackx/LeftTPJ_to_precuneus --waycond=AND;
sem -j+0 probtrackx2 -x ${i}/IndivMasks/${i}_leftTPJ_dif.nii.gz -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --waypoints=${i}/IndivMasks/${i}_dmPFC_dif.nii.gz --stop=${i}/IndivMasks/${i}_dmPFC_dif.nii.gz --forcedir --opd -s ${i}/Diffusion.bedpostX/merged -m ${i}/Diffusion.bedpostX/nodif_brain_mask --dir=${i}/probtrackx/LeftTPJ_to_dmPFC --waycond=AND;
sem -j+0 probtrackx2 -x ${i}/IndivMasks/${i}_leftTPJ_dif.nii.gz -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --waypoints=${i}/IndivMasks/${i}_lefttemppole_dif.nii.gz --stop=${i}/IndivMasks/${i}_lefttemppole_dif.nii.gz --forcedir --opd -s ${i}/Diffusion.bedpostX/merged -m ${i}/Diffusion.bedpostX/nodif_brain_mask --dir=${i}/probtrackx/LeftTPJ_to_lefttemppole --waycond=AND;
sem -j+0 probtrackx2 -x ${i}/IndivMasks/${i}_leftTPJ_dif.nii.gz -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --waypoints=${i}/IndivMasks/${i}_righttemppole_dif.nii.gz --stop=${i}/IndivMasks/${i}_righttemppole_dif.nii.gz --forcedir --opd -s ${i}/Diffusion.bedpostX/merged -m ${i}/Diffusion.bedpostX/nodif_brain_mask --dir=${i}/probtrackx/LeftTPJ_to_righttemppole --waycond=AND;
sem -j+0 probtrackx2 -x ${i}/IndivMasks/${i}_leftTPJ_dif.nii.gz -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --waypoints=${i}/IndivMasks/${i}_L-L_Amyg_corr.nii.gz --stop=${i}/IndivMasks/${i}_L-L_Amyg_corr.nii.gz --forcedir --opd -s ${i}/Diffusion.bedpostX/merged -m ${i}/Diffusion.bedpostX/nodif_brain_mask --dir=${i}/probtrackx/LeftTPJ_to_leftAmyg --waycond=AND;
sem -j+0 probtrackx2 -x ${i}/IndivMasks/${i}_leftTPJ_dif.nii.gz -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --waypoints=${i}/IndivMasks/${i}_R-R_Amyg_corr.nii.gz --stop=${i}/IndivMasks/${i}_R-R_Amyg_corr.nii.gz --forcedir --opd -s ${i}/Diffusion.bedpostX/merged -m ${i}/Diffusion.bedpostX/nodif_brain_mask --dir=${i}/probtrackx/LeftTPJ_to_rightAmyg --waycond=AND;

sem --wait
echo 'done computing'

cp -a $WORKDIR/probtrackx/${i}/probtrackx $ORIGDIR/${i}/ 

echo 'done with script'
done

rm -Rf $WORKDIR/probtrackx