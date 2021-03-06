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

cd ../files/aa_ortholog_families_NOT_aligned_woutgroup/
# Move to the folder containing all the families one wants to compare
all_families=$( find family* )

# We will surely miss the best trees, so must first find it for all of the single gene trees:
cd ../phylogenetic_trees/aa_gene_trees_woutgroup/all_families/
# Will first take out the reduced one
rm *.reduced
for family in $all_families; do
    if [ ! -f RAxML_bestTree.$family ] ; then
        # Find last lines | look for the 5th element (log-likelihood values) | sort all of them | take the last (max)
        best_LogL=$( grep 'written' RAxML_info.$family | awk '{print $5}' | sort -n | tail -1 )
        # Check for the first tree with this log-likelihood value | take the identifier | take identifier number
        best_tree=$( grep -- $best_LogL RAxML_info.$family | awk '{print $1}' | grep -m1 -Eo '[0-9]{1,4}' )
        # Create the bestTree
        cp RAxML_result.$family.RUN.$best_tree RAxML_bestTree.$family
    fi
done

cat RAxML_bestTree.family_* >> ../concatanated_gene_trees_woutgroup

cd $way_back

python3 simplify_names_gene_trees.py ../files/phylogenetic_trees/aa_gene_trees_woutgroup/concatanated_gene_trees_woutgroup \
    ../files/phylogenetic_trees/aa_gene_trees_woutgroup/cleaned_concatanated_gene_trees_woutgroup \
    ../data/woutgroup_file_list