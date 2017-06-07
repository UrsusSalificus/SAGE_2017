#!/usr/bin/env bash

# To use : bsub < ./bsub_gene_trees_complete.sh
# Will use multithread on same host (-n = number of cores, -R one the same node/host)

#BSUB -L /bin/bash
#BSUB -e error_c_genes.txt
#BSUB -J c_genes
#BSUB -n 24
#BSUB –R "span[hosts=1]"
#BSUB -M 40194304
#BSUB -R "rusage[mem=40000]"

module add Phylogeny/raxml/8.2.9;

cd ../files/aa_ortholog_families_aligned_complete/
# Move to the folder containing all the families one wants to compare
all_families=$( find family* )

if [ ! -d "../phylogenetic_trees/aa_gene_trees_complete/all_families" ] ; then
   mkdir -p ../phylogenetic_trees/aa_gene_trees_complete/all_families
fi
cd ../phylogenetic_trees/aa_gene_trees_complete/all_families

for family in $all_families; do
    # ML, no bootstrap, 20 trees for each single gene tree
    raxmlHPC-HYBRID -m PROTGAMMAWAG -p 12345 -s ../../../aa_ortholog_families_aligned_complete/$family \
    -n $family -N 20 -T 16 ­­set­thread­affinity
done

