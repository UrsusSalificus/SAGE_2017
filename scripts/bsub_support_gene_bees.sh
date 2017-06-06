#!/usr/bin/env bash

# To use : bsub < ./bsub_support_gene_bees.sh
# Will use multithread on same host (-n = number of cores, -R one the same node/host)

#BSUB -L /bin/bash
#BSUB -J b_support_gene
#BSUB -e error_b_support_gene.txt
#BSUB -n 4
#BSUB –R "span[hosts=1]"
#BSUB -M 40194304
#BSUB -R "rusage[mem=40000]"

module add Phylogeny/raxml/8.2.9;

cd ../files/phylogenetic_trees/dna_nobootstrap_bees

# Compute bootstrap support of "best tree":
 raxmlHPC -m GTRCAT -p 12345 -f b -t RAxML_bestTree.bees_nobootstrap \
 -z ../dna_gene_trees_bees/cleaned_concatanated_gene_trees_bees -n bees_gene_supported.tree
