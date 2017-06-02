#!/usr/bin/env bash

# To use : bsub < ./bsub_aligning.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Takes approximately 10 min for the 548 families.

#BSUB -L /bin/bash
#BSUB -e error_MAFFT.txt
#BSUB -J MAFFT
#BSUB -n 64
#BSUB -M 10485760

module add SequenceAnalysis/MultipleSequenceAlignment/mafft/7.305;

# Move to the folder containing all the families one wants to align
cd /scratch/beegfs/monthly/mls_2016/phylogeny/files/aa_ortholog_families_NOT_aligned_woutgroup/
all_families=$( find family* )

# Specify which folder will contain the aligned families
out_folder=$'/scratch/beegfs/monthly/mls_2016/phylogeny/files/aa_ortholog_families_aligned_woutgroup/'
if [ ! -d "$out_folder" ]; then
  mkdir $out_folder
fi

for i in $all_families; do
    mafft --auto $i > $out_folder$i
done



