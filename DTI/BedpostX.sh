#!/bin/bash

ulimit -s unlimited

module load FSL/5.0.8-intel-2014b-pbs
. ${FSLDIR}/etc/fslconf/fsl.sh

FSLOUTPUTTYPE=NIFTI_GZ
export FSLOUTPUTTYPE

# enable parallel processing by submitting jobs to the queue
export SGE_ROOT=PBS

export FSLSUBVERBOSE=1

# -c: do not try to use CUDA

for i in `sed -n "${PBS_ARRAYID}p" subject_ID_short2.txt`;
do
echo ${i}

bedpostx ${i}/Diffusion -c

done
