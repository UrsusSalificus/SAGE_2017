#!/usr/bin/env bash

# To use : bsub < ./bsub_concatenating_gene_trees.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Takes approximately 1 min for the 548 families.

#BSUB -L /bin/bash
#BSUB -e error_concat_gt.txt
#BSUB -J concat_gt
#BSUB -n 64
#BSUB -M 10485760

cat ../files/phylogenetic_trees/aa_ML_noboot_gene_trees/all_families/family_1/RAxML_result.family_* \
>> ../files/phylogenetic_trees/aa_ML_noboot_gene_trees/concat_all_gene_trees
