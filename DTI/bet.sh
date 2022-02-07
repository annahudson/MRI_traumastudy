#!/bin/bash

#PBS -N bet
#PBS -o bet.log
#PBS -e bet.err
#PBS -q default
#PBS -l walltime=01:00:00
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

mkdir -p $WORKDIR/bet
cd $WORKDIR/bet
pwd

cp $ORIGDIR/subject_ID_short2.txt $WORKDIR/bet/subject_ID_short2.txt

for i in `sed -n "${PBS_ARRAYID}p" subject_ID_short2.txt`;
do 
echo ${i}

cp -a $ORIGDIR/${i}/ $WORKDIR/bet/
echo 'done copying'

bet ${i}/Diffusion/data_eddy.nii.gz ${i}/Diffusion/data.nii.gz -F -m

bet ${i}/structural/struct_reorient.nii.gz ${i}/structural/struct_bet.nii.gz  

cp -a -v $WORKDIR/bet/${i}/Diffusion/data.nii.gz $ORIGDIR/${i}/Diffusion
cp -a -v $WORKDIR/bet/${i}/Diffusion/data_mask.nii.gz $ORIGDIR/${i}/Diffusion
cp -a -v $WORKDIR/bet/${i}/structural/struct_bet.nii.gz $ORIGDIR/${i}/structural

done

rm -Rf $WORKDIR/
