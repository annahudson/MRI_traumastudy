#!/bin/bash

#PBS -N Registration
#PBS -o registration.log
#PBS -e registration.err
#PBS -q default
#PBS -l walltime=11:00:00
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

mkdir -p $WORKDIR/Registration
cd $WORKDIR/Registration
pwd

cp $ORIGDIR/subject_ID_short2.txt subject_ID_short2.txt

for i in `sed -n "${PBS_ARRAYID}p" subject_ID_short2.txt`
do 
echo ${i}

cp -a $ORIGDIR/${i}/ $WORKDIR/Registration/
echo 'done copying'

flirt -ref ${i}/structural/struct_bet.nii.gz -in ${i}/Diffusion/data.nii.gz -out ${i}/dif2struct.nii.gz -omat ${i}/dif2struct.mat
flirt -ref $FSLDIR/data/standard/MNI152_T1_2mm_brain.nii.gz -in ${i}/structural/struct_bet.nii.gz -out ${i}/struct2standard_flirt.nii.gz -omat ${i}/struct2standard_flirt.mat
fnirt --in=${i}/structural/struct_reorient.nii.gz  --aff=${i}/struct2standard_flirt.mat --cout=${i}/struct2standard.nii.gz --iout=${i}/struct2standardimage.nii.gz --config=${FSLDIR}/etc/flirtsch/T1_2_MNI152_2mm.cnf 
convert_xfm -omat ${i}/struct2dif.mat -inverse ${i}/dif2struct.mat
invwarp -w ${i}/struct2standard.nii.gz -o ${i}/standard2struct.nii.gz -r ${i}/structural/struct_bet.nii.gz

cp $WORKDIR/Registration/${i}/dif2struct.mat $ORIGDIR/${i}/
cp $WORKDIR/Registration/${i}/struct2standard_flirt.nii.gz $ORIGDIR/${i}/
cp $WORKDIR/Registration/${i}/struct2standard_flirt.mat $ORIGDIR/${i}/
cp $WORKDIR/Registration/${i}/struct2standard.nii.gz $ORIGDIR/${i}/
cp $WORKDIR/Registration/${i}/struct2standardimage.nii.gz $ORIGDIR/${i}/
cp $WORKDIR/Registration/${i}/standard2struct.nii.gz $ORIGDIR/${i}/
cp $WORKDIR/Registration/${i}/struct2dif.mat $ORIGDIR/${i}/
cp $WORKDIR/Registration/${i}/dif2struct.nii.gz $ORIG/${i}/

done
