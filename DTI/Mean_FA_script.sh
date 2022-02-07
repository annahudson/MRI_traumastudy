#!/bin/bash

#PBS -N Mean_FA
#PBS -o mean_FA.log
#PBS -e mean_FA.err
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

mkdir -p $WORKDIR/DTIFITFA
cd $WORKDIR/DTIFITFA
pwd

cp $ORIGDIR/subject_ID_anna_all.txt subject_ID_anna_all.txt

for i in `sed -n "${PBS_ARRAYID}p" subject_ID_anna_all.txt`;   
do 
mkdir -p ${i}
cp -a  $ORIGDIR/${i}/Diffusion/dtifit $WORKDIR/DTIFITFA/${i}/dtifit

echo ${i}

fslstats ${i}/dtifit/dtifit_FA.nii.gz -M

done

rm -Rf $WORKDIR/DTIFITFA
