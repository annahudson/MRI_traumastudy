#!/bin/bash

ulimit -s unlimited
module load scripts

cd <path/to/data>  <- CHANGE THIS
pwd

echo 'SubjID,Left-Lateral-Ventricle,Left-Inf-Lat-Vent,Left-Cerebellum-White-Matter,Left-Cerebellum-Cortex,Left-Thalamus-Proper,Left-Caudate,Left-Putamen,Left-Pallidum,3rd-Ventricle,4th-Ventricle,Brain-Stem,Left-Hippocampus,Left-Amygdala,CSF,Left-Accumbens-area,Left-VentralDC,Left-vessel,Left-choroid-plexus,Right-Lateral-Ventricle,Right-Inf-Lat-Vent,Right-Cerebellum-White-Matter,Right-Cerebellum-Cortex,Right-Thalamus-Proper,Right-Caudate,Right-Putamen,Right-Pallidum,Right-Hippocampus,Right-Amygdala,Right-Accumbens-area,Right-VentralDC,Right-vessel,Right-choroid-plexus,5th-Ventricle,Optic-Chiasm,CC_Posterior,CC_Mid_Posterior,CC_Central,CC_Mid_Anterior,CC_Anterior,TotalGreyVol,SubCorticalGreyVol,ICV' > SubcorticalMeasures_Volume.csv

for subj_id in `sed -n "${PBS_ARRAYID}p" subject_all.txt`; 

do

echo ${subj_id}

printf "%s,"  "${subj_id}" >> SubcorticalMeasures_Volume.csv

for x in Left-Lateral-Ventricle Left-Inf-Lat-Vent Left-Cerebellum-White-Matter Left-Cerebellum-Cortex Left-Thalamus-Proper Left-Caudate Left-Putamen Left-Pallidum 3rd-Ventricle 4th-Ventricle Brain-Stem Left-Hippocampus Left-Amygdala CSF Left-Accumbens-area Left-VentralDC Left-vessel Left-choroid-plexus Right-Lateral-Ventricle Right-Inf-Lat-Vent Right-Cerebellum-White-Matter Right-Cerebellum-Cortex Right-Thalamus-Proper Right-Caudate Right-Putamen Right-Pallidum Right-Hippocampus Right-Amygdala Right-Accumbens-area Right-VentralDC Right-vessel Right-choroid-plexus 5th-Ventricle Optic-Chiasm CC_Posterior CC_Mid_Posterior CC_Central CC_Mid_Anterior CC_Anterior;

do

printf "%s," `grep -w ${x} ${subj_id}/stats/aseg.stats | awk '{print $4}'` >> SubcorticalMeasures_Volume.csv

done

printf "%s," `cat ${subj_id}/stats/aseg.stats | grep TotalGray | awk -F, '{print $4}'` >> SubcorticalMeasures_Volume.csv
printf "%s," `cat ${subj_id}/stats/aseg.stats | grep SubCortGray | awk -F, '{print $4}'` >> SubcorticalMeasures_Volume.csv
printf "%s" `cat ${subj_id}/stats/aseg.stats | grep IntraCranialVol | awk -F, '{print $4}'` >> SubcorticalMeasures_Volume.csv

echo "" >> SubcorticalMeasures_Volume.csv

done
