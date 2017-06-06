#!/usr/bin/env bash

# To use : bsub < ./bsub_merging_bees.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Takes approximately 10 sec for the 548 trees.

#BSUB -L /bin/bash
#BSUB -e error_b_merg.txt
#BSUB -J b_merg
#BSUB -n 4
#BSUB -M 10485760

python3 merging_support.py ../files/phylogenetic_trees/dna_nobootstrap_bees/RAxML_bipartitions.bees_boot_supported.tree \
    ../files/phylogenetic_trees/dna_nobootstrap_bees/RAxML_bipartitions.bees_gene_supported.tree \
    ../files/phylogenetic_trees/bees_merged_boot_gene.tree

