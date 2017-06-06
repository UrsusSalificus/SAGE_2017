#!/usr/bin/env bash

# To use : bsub < ./bsub_concat_gene_bees.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Takes approximately 10 sec for the 548 families.

#BSUB -L /bin/bash
#BSUB -J b_concat_gene
#BSUB -e error_b_concat_gene.txt
#BSUB -n 4
#BSUB -M 10485760

# Check where we are to come back later on:
way_back=$( pwd )

cd ../files/phylogenetic_trees/dna_gene_trees_bees/all_families/

cat RAxML_bestTree.family_* >> ../concatanated_gene_trees_bees

cd $way_back

python3 simplify_names_gene_trees.py ../files/phylogenetic_trees/dna_gene_trees_bees/concatanated_gene_trees_bees \
    ../files/phylogenetic_trees/dna_gene_trees_bees/cleaned_concatanated_gene_trees_bees ../data/bees_file_list