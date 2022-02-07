#!/bin/bash

#PBS -N Personalise_masks
#PBS -o applywarp.log
#PBS -e applywarp.err
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

mkdir -p $WORKDIR/Individual_masks
cd $WORKDIR/Individual_masks
pwd

cp -a  $ORIGDIR/Masks/ $WORKDIR/Individual_masks/
cp $ORIGDIR/subject_ID_short2.txt subject_ID_short2.txt

for i in `sed -n "${PBS_ARRAYID}p" subject_ID_short2.txt`;  
do 
echo ${i}

mkdir -p ${i}

cp -a  $ORIGDIR/${i}/standard2struct.nii.gz $WORKDIR/Individual_masks/${i}/standard2struct.nii.gz
cp -a  $ORIGDIR/${i}/struct2dif.mat $WORKDIR/Individual_masks/${i}/struct2dif.mat
cp -a  $ORIGDIR/${i}/Diffusion/data.nii.gz $WORKDIR/Individual_masks/${i}/data.nii.gz
cp -a  $ORIGDIR/${i}/structural/ $WORKDIR/Individual_masks/${i}/structural/
pwd

applywarp -i Masks/ltpj_mask.nii.gz -o ${i}/leftTPJ_struct -r ${i}/structural/struct_bet.nii.gz -w ${i}/standard2struct.nii.gz;
flirt -ref ${i}/data.nii.gz -in ${i}/leftTPJ_struct -applyxfm -init ${i}/struct2dif.mat -out ${i}/${i}_leftTPJ_dif;

applywarp -i Masks/rtpj_mask.nii.gz -o ${i}/rightTPJ_struct -r ${i}/structural/struct_bet.nii.gz -w ${i}/standard2struct.nii.gz;
flirt -ref ${i}/data.nii.gz -in ${i}/rightTPJ_struct -applyxfm -init ${i}/struct2dif.mat -out ${i}/${i}_rightTPJ_dif;

applywarp -i Masks/leftAI_10_mask.nii.gz -o ${i}/leftAI_struct -r ${i}/structural/struct_bet.nii.gz -w ${i}/standard2struct.nii.gz;
flirt -ref ${i}/data.nii.gz -in ${i}/leftAI_struct -applyxfm -init ${i}/struct2dif.mat -out ${i}/${i}_leftAI_dif;

applywarp -i Masks/rightAI_10_mask.nii.gz -o ${i}/rightAI_struct -r ${i}/structural/struct_bet.nii.gz -w ${i}/standard2struct.nii.gz;
flirt -ref ${i}/data.nii.gz -in ${i}/rightAI_struct -applyxfm -init ${i}/struct2dif.mat -out ${i}/${i}_rightAI_dif;

applywarp -i Masks/ltemp_mask.nii.gz -o ${i}/lefttemppole_struct -r ${i}/structural/struct_bet.nii.gz -w ${i}/standard2struct.nii.gz;
flirt -ref ${i}/data.nii.gz -in ${i}/lefttemppole_struct -applyxfm -init ${i}/struct2dif.mat -out ${i}/${i}_lefttemppole_dif;

applywarp -i Masks/rtemp_mask.nii.gz -o ${i}/righttemppole_struct -r ${i}/structural/struct_bet.nii.gz -w ${i}/standard2struct.nii.gz;
flirt -ref ${i}/data.nii.gz -in ${i}/righttemppole_struct -applyxfm -init ${i}/struct2dif.mat -out ${i}/${i}_righttemppole_dif;

applywarp -i Masks/dmpfc_mask.nii.gz -o ${i}/dmPFC_struct -r ${i}/structural/struct_bet.nii.gz -w ${i}/standard2struct.nii.gz;
flirt -ref ${i}/data.nii.gz -in ${i}/dmPFC_struct -applyxfm -init ${i}/struct2dif.mat -out ${i}/${i}_dmPFC_dif;

applywarp -i Masks/precuneus_mask.nii.gz -o ${i}/precuneus_struct -r ${i}/structural/struct_bet.nii.gz -w ${i}/standard2struct.nii.gz;
flirt -ref ${i}/data.nii.gz -in ${i}/precuneus_struct -applyxfm -init ${i}/struct2dif.mat -out ${i}/${i}_precuneus_dif;

cp -a $WORKDIR/Individual_masks/${i}/${i}_leftTPJ_dif.nii.gz $ORIGDIR/${i}/IndividualMasks/
cp -a $WORKDIR/Individual_masks/${i}/${i}_rightTPJ_dif.nii.gz $ORIGDIR/${i}/IndividualMasks/
cp -a $WORKDIR/Individual_masks/${i}/${i}_leftAI_dif.nii.gz $ORIGDIR/${i}/IndividualMasks/
cp -a $WORKDIR/Individual_masks/${i}/${i}_rightAI_dif.nii.gz $ORIGDIR/${i}/IndividualMasks/
cp -a $WORKDIR/Individual_masks/${i}/${i}_lefttemppole_dif.nii.gz $ORIGDIR/${i}/IndividualMasks/
cp -a $WORKDIR/Individual_masks/${i}/${i}_righttemppole_dif.nii.gz $ORIGDIR/${i}/IndividualMasks/
cp -a $WORKDIR/Individual_masks/${i}/${i}_dmPFC_dif.nii.gz $ORIGDIR/${i}/IndividualMasks/
cp -a $WORKDIR/Individual_masks/${i}/${i}_precuneus_dif.nii.gz $ORIGDIR/${i}/IndividualMasks/

done

rm -Rf $WORKDIR/Individual_masks 
