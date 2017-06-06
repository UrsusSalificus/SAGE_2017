#!/usr/bin/env bash

# To use : bsub < ./bsub_concatenating_beessh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Takes approximately 10 sec for the 548 families.

#BSUB -L /bin/bash
#BSUB -e error_concat.txt
#BSUB -J concat
#BSUB -n 4
#BSUB –R "span[ptile=4]"
#BSUB -M 10485760

python3 concatenating_all_aligned.py ../files/dna_ortholog_families_aligned_bees/ \
    ../files/concatanated_dna_aligned_orthologs_bees