#!/usr/bin/env bash

# To use : bsub < ./bsub_aligning_complete.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Takes approximately 10 min for the 548 families.

#BSUB -L /bin/bash
#BSUB -e error_MAFFT.txt
#BSUB -J MAFFT
#BSUB -n 16
#BSUB –R "span[ptile=16]"
#BSUB -M 10485760

module add SequenceAnalysis/MultipleSequenceAlignment/mafft/7.305;


# Move to the folder (first argument) containing all the families one wants to align
cd ../files/aa_ortholog_families_NOT_aligned_complete/
all_families=$( find family* )

# Specify which folder (second argument) will contain the aligned families
out_folder=$'../aa_ortholog_families_aligned_complete/'
mkdir $out_folder

# Do the alignement for all the families
for i in $all_families; do
    mafft --auto --thread 16 $i > $out_folder$i
done



