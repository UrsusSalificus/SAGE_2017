#!/usr/bin/env bash

# To use : bsub < ./bsub_concat_gene_woutgroup.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Takes approximately 10 sec for the 548 families.

#BSUB -L /bin/bash
#BSUB -J w_concat_gene
#BSUB -e error_w_concat_gene.txt
#BSUB -n 4
#BSUB -M 10485760

# Check where we are to come back later on:
way_back=$( pwd )

cd ../files/phylogenetic_trees/aa_gene_trees_woutgroup/all_families/

cat RAxML_bestTree.family_* >> ../concatanated_gene_trees_woutgroup

cd $way_back

python3 simplify_names_gene_trees.py ../files/phylogenetic_trees/aa_gene_trees_woutgroup/concatanated_gene_trees_woutgroup \
    ../files/phylogenetic_trees/aa_gene_trees_woutgroup/cleaned_concatanated_gene_trees_woutgroup \
    ../data/woutgroup_file_list