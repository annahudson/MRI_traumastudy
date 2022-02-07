#!/bin/bash

#PBS -N Amygdala_size
#PBS -o Amygsize.log
#PBS -e Amygsize.err
#PBS -q default
#PBS -l walltime=00:30:00
#PBS -l nodes=1:ppn=1
#PBS -m ae

ulimit -s unlimited
module load scripts

module load FSL/5.0.8-intel-2014b-pbs
. ${FSLDIR}/etc/fslconf/fsl.sh

FSLOUTPUTTYPE=NIFTI_GZ
export FSLOUTPUTTYPE

ORIGDIR=$PBS_O_WORKDIR
WORKDIR=$VSC_SCRATCH/$PBS_JOBID
#WORKDIR=$VSC_SCRATCH_DELCATTY/$PBS_JOBID

echo Hostname: $(hostname)
echo ORIGDIR: $ORIGDIR
echo WORKDIR: $WORKDIR

mkdir -p $WORKDIR/Amygdala
cd $WORKDIR/Amygdala
pwd

cp $ORIGDIR/subject_ID_short.txt subject_ID_short.txt

echo 'first Left then Right'

for i in `sed -n "${PBS_ARRAYID}p" subject_ID_short.txt`;   
do 
echo ${i}

mkdir -p ${i}
cp -a  $ORIGDIR/${i}/IndividualMasks/ $WORKDIR/Amygdala/${i}/IndividualMasks/

pwd

fslstats ${i}/IndividualMasks/hajek_L-L_Amyg_corr.nii.gz -V
fslstats ${i}/IndividualMasks/hajek_R-R_Amyg_corr.nii.gz -V

done

rm -Rf $WORKDIR/Amygdala
