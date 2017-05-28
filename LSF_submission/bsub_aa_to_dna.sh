#!/usr/bin/env bash

# To use : bsub < ./bsub_aa_to_dna.sh
# Will use multithread on same host (-n = number of cores, -R = same host)

#BSUB -L /bin/bash
#BSUB -e error_aa_to_dna.txt
#BSUB -J aa_to_dna
#BSUB -n 4
#BSUB –R "span[ptile=4]"
#BSUB -M 10485760
#BSUB –R "rusage[mem=10240]"

# Move to the folder containing all the families one wants to align
cd /scratch/beegfs/monthly/mls_2016/phylogeny/files/DNA_ortholog_families_NOT_aligned/
all_families=$( find family* )

# Move to the folder which will contain all the aligned families
cd /scratch/beegfs/monthly/mls_2016/phylogeny/files/DNA_ortholog_families_aligned_by_aa/
# Create l empty files (where l = number of families)
for i in $all_families; do
    > $i
done

# Come back to the scripts folder, and execute the python script
cd /scratch/beegfs/monthly/mls_2016/phylogeny/scripts
python3 aa_to_DNA.py