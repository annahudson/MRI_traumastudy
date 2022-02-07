#!/bin/bash

#PBS -N reorient
#PBS -o reorient.log
#PBS -e reorient.err
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

mkdir -p $WORKDIR/reorient
cd $WORKDIR/reorient
pwd

cp $ORIGDIR/subject_ID_short2.txt $WORKDIR/reorient/subject_ID_short2.txt

for i in `sed -n "${PBS_ARRAYID}p" subject_ID_short2.txt`;
do 
echo ${i}

cp -a $ORIGDIR/${i}/ $WORKDIR/reorient/
echo 'done copying'

fslreorient2std ${i}/structural/struct.nii ${i}/structural/struct_reorient.nii.gz 
fslreorient2std ${i}/Diffusion/data_raw.nii.gz ${i}/Diffusion/data_raw_reorient.nii.gz 

cp -a -v $WORKDIR/reorient/${i}/structural/struct_reorient.nii.gz $ORIGDIR/${i}/structural
cp -a -v $WORKDIR/reorient/${i}/Diffusion/data_raw_reorient.nii.gz $ORIGDIR/${i}/Diffusion

done

rm -Rf $WORKDIR/
