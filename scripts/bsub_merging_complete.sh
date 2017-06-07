#!/usr/bin/env bash

# To use : bsub < ./bsub_merging_complete.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Takes approximately 10 sec for the 548 trees.

#BSUB -L /bin/bash
#BSUB -e error_c_merg.txt
#BSUB -J c_merg
#BSUB -n 4
#BSUB -M 10485760

python3 merging_support.py ../files/phylogenetic_trees/aa_nobootstrap_complete/RAxML_bipartitions.complete_boot_supported.tree \
    ../files/phylogenetic_trees/aa_nobootstrap_complete/RAxML_bipartitions.complete_gene_supported.tree \
    ../files/phylogenetic_trees/complete_merged_boot_gene.tree

