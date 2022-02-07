#!/bin/bash

#PBS -N Waytotal
#PBS -o waytotal.log
#PBS -e waytotal.err
#PBS -q default
#PBS -l walltime=05:00:00
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

mkdir -p $WORKDIR/waytotal
cd $WORKDIR/waytotal
pwd

cp $ORIGDIR/subject_ID_anna_all.txt subject_ID_anna_all.txt

for i in `sed -n "${PBS_ARRAYID}p" subject_ID_anna_all.txt`;   
do 
echo ${i}

mkdir -p ${i}
cp -a  $ORIGDIR/${i}/probtrackx/ $WORKDIR/waytotal/${i}/

cd ${i}/probtrackx

echo 'LTPJ_to_LAmyg'
echo "$(cat LeftTPJ_to_leftAmyg/waytotal)"
echo 'LAmyg_to_LTPJ'
echo "$(cat LeftAmyg_to_leftTPJ/waytotal)"

echo 'LTPJ_to_LAI'
echo "$(cat LeftTPJ_to_leftAI/waytotal)"
echo 'LAI_to_LTPJ'
echo "$(cat LeftAI_to_leftTPJ/waytotal)"

echo 'LTPJ_to_Precuneus'
echo "$(cat LeftTPJ_to_precuneus/waytotal)"
echo 'Precuneus_to_LTPJ'
echo "$(cat Precuneus_to_leftTPJ/waytotal)"

echo 'LTPJ_to_dmPFC'
echo "$(cat LeftTPJ_to_dmPFC/waytotal)"
echo 'dmPFC_to_LTPJ'
echo "$(cat dmPFC_to_leftTPJ/waytotal)"

echo 'LTPJ_to_LTempPole'
echo "$(cat LeftTPJ_to_lefttemppole/waytotal)"
echo 'LTempPole_to_LTPJ'
echo "$(cat Lefttemppole_to_leftTPJ/waytotal)"

echo 'RTPJ_to_RAmyg'
echo "$(cat RightTPJ_to_rightAmyg/waytotal)"
echo 'RAmyg_to_RTPJ'
echo "$(cat RightAmyg_to_rightTPJ/waytotal)"

echo 'RTPJ_to_RAI'
echo "$(cat RightTPJ_to_rightAI/waytotal)"
echo 'RAI_to_RTPJ'
echo "$(cat RightAI_to_rightTPJ/waytotal)"

echo 'RTPJ_to_Precuneus'
echo "$(cat RightTPJ_to_precuneus/waytotal)"
echo 'Precuneus_to_RTPJ'
echo "$(cat Precuneus_to_rightTPJ/waytotal)"

echo 'RTPJ_to_dmPFC'
echo "$(cat RightTPJ_to_dmPFC/waytotal)"
echo 'dmPFC_to_RTPJ'
echo "$(cat dmPFC_to_rightTPJ/waytotal)"

echo 'RTPJ_to_RTempPole'
echo "$(cat RightTPJ_to_righttemppole/waytotal)"
echo 'RTempPole_to_RTPJ'
echo "$(cat Righttemppole_to_rightTPJ/waytotal)"


cd $WORKDIR/waytotal

done

rm -Rf $WORKDIR/waytotal
