#!/bin/bash

#PBS -N eddy
#PBS -o eddy.log
#PBS -e eddy.err
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

mkdir -p $WORKDIR/eddy
cd $WORKDIR/eddy
pwd

cp $ORIGDIR/subject_ID_short2.txt $WORKDIR/eddy/subject_ID_short2.txt

for i in `sed -n "${PBS_ARRAYID}p" subject_ID_short2.txt`;
do 
echo ${i}

cp -a $ORIGDIR/${i}/ $WORKDIR/eddy/
echo 'done copying'

eddy_correct ${i}/Diffusion/data_raw_reorient.nii.gz ${i}/Diffusion/data_eddy.nii.gz 0

cp -a -v $WORKDIR/eddy/${i}/Diffusion/data_eddy.nii.gz $ORIGDIR/${i}/Diffusion

done

rm -Rf $WORKDIR/eddy
