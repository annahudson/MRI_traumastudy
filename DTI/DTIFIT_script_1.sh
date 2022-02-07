#!/bin/bash

#PBS -N dtifit1
#PBS -o dtifit_1.log
#PBS -e dtifit_1.err
#PBS -q default
#PBS -l walltime=02:30:00
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

mkdir -p $WORKDIR/probtrackx
cd $WORKDIR/probtrackx/
pwd

cp $ORIGDIR/subject_ID_short2.txt $WORKDIR/probtrackx/subject_ID_short2.txt

for i in `sed -n "${PBS_ARRAYID}p" subject_ID_short2.txt`;   
do 
echo ${i}

cp -a  $ORIGDIR/${i} $WORKDIR/probtrackx/
echo 'done copying'
pwd

mkdir ${i}/Diffusion/dtifit/

pwd

dtifit -k ${i}/Diffusion/data.nii.gz -m ${i}/Diffusion/nodif_brain_mask.nii.gz -r ${i}/Diffusion/bvecs -b ${i}/Diffusion/bvals -o ${i}/Diffusion/dtifit/dtifit

cp -a $WORKDIR/probtrackx/${i}/Diffusion/dtifit/ $ORIGDIR/${i}/Diffusion/

done

rm -Rf $WORKDIR/probtrackx/