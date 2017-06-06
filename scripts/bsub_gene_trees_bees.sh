#!/usr/bin/env bash

# To use : bsub < ./bsub_gene_trees_bees.sh
# Will use multithread on same host (-n = number of cores, -R = same host)

#BSUB -L /bin/bash
#BSUB -e error_b_gene.txt
#BSUB -J b_gene
#BSUB -n 12
#BSUB –R "span[hosts=1]"
#BSUB -M 40194304
#BSUB -R "rusage[mem=40000]"

module add Phylogeny/raxml/8.2.9;

cd ../files/dna_ortholog_families_aligned_bees/
# Move to the folder containing all the families one wants to compare
all_families=$( find family* )

if [ ! -d "../phylogenetic_trees/dna_gene_trees_bees/all_families" ] ; then
   mkdir -p ../phylogenetic_trees/dna_gene_trees_bees/all_families
fi
cd ../phylogenetic_trees/dna_gene_trees_bees/all_families

for family in $all_families; do
    # ML, no bootstrap, 20 trees for each single gene tree
    raxmlHPC -m GTRGAMMA -p 12345 -s ../../../dna_ortholog_families_aligned_bees/$family \
    -n $family -N 20
done

