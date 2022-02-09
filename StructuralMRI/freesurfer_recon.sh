#!/bin/bash

#PBS -N fs_recon1
#PBS -o freesurfer_recon1.log
#PBS -e freesurfer_recon1.err
#PBS -q default
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=1
#PBS -m ae

ulimit -s unlimited
module load scripts

module load FreeSurfer
. $FREESURFER_HOME/SetUpFreeSurfer.sh 

ORIGDIR=$PBS_O_WORKDIR
WORKDIR=$VSC_SCRATCH_NODE/$PBS_JOBID
#WORKDIR=$VSC_SCRATCH_NODE/$PBS_JOBID

echo Hostname: $(hostname)
echo ORIGDIR: $ORIGDIR
echo WORKDIR: $WORKDIR

mkdir -p $WORKDIR/fs_recon
cd $WORKDIR/fs_recon

export SUBJECTS_DIR=$WORKDIR/fs_recon
echo SUBJECTS_DIR: $SUBJECTS_DIR

cp $ORIGDIR/subject_ID_anna_1.txt $WORKDIR/fs_recon/subject_ID_anna_1.txt

for i in `sed -n "${PBS_ARRAYID}p" subject_ID_anna_1.txt`;
do
echo ${i}

cp -a $ORIGDIR/${i}/ $WORKDIR/fs_recon/
echo 'done copying'
pwd

recon-all -i ${i}/structural/struct.nii -subject ${i}/StructRecon_${i} -all

cp -a -v $WORKDIR/fs_recon/StructRecon_${i}/ $ORIGDIR/${i}/

done

rm -Rf $WORKDIR/