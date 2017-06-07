#!/usr/bin/env bash

# To use : bsub < ./bsub_support_gene_complete.sh
# Will use multithread on same host (-n = number of cores, -R one the same node/host)

#BSUB -L /bin/bash
#BSUB -J c_support_gene
#BSUB -e error_c_support_gene.txt
#BSUB -n 4
#BSUB –R "span[hosts=1]"
#BSUB -M 40194304
#BSUB -R "rusage[mem=40000]"

module add Phylogeny/raxml/8.2.9;

cd ../files/phylogenetic_trees/aa_nobootstrap_complete

# Compute bootstrap support of "best tree":
 raxmlHPC -m PROTGAMMAWAG -p 12345 -f b -t RAxML_bestTree.complete_nobootstrap \
 -z ../aa_gene_trees_complete/cleaned_concatanated_gene_trees_complete -n complete_gene_supported.tree
