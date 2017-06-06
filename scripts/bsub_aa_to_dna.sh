#!/usr/bin/env bash

# To use : bsub < ./bsub_aa_to_dna.sh
# Will use multithread on same host (-n = number of cores, -R = same host)

#BSUB -L /bin/bash
#BSUB -e error_aa_to_dna.txt
#BSUB -J aa_to_dna
#BSUB -n 4
#BSUB –R "span[hosts=1]"
#BSUB -M 10485760

# Check where we are to come back later on:
way_back=$( pwd )

# Move to the folder containing all the families one wants to align
cd ../files/dna_ortholog_families_NOT_aligned_bees/
all_families=$( find family* )

# Move to the folder which will contain all the aligned families
out_folder=$'../dna_ortholog_families_aligned_bees/'
if [ ! -d "$out_folder" ]; then
  mkdir $out_folder
fi
cd $out_folder
# Create l empty files (where l = number of families) -> due to issue in the python script
for i in $all_families; do
    > $i
done

# Come back to the scripts folder, and execute the python script
cd $way_back
python3 aa_to_DNA.py