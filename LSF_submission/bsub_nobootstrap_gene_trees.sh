#!/usr/bin/env bash

# To use : bsub < ./bsub_nobootstrap_gene_trees.sh
# Will use multithread on same host (-n = number of cores, -R = same host)

#BSUB -L /bin/bash
#BSUB -e error_RAxML_genes.txt
#BSUB -J RAxML_genes
#BSUB -n 64
#BSUB -M 10485760

module add Phylogeny/raxml/8.2.9;

name=$'aa_ML_noboot'

# Move to the folder containing all the families one wants to align
# 1) All genomes:
#cd /scratch/beegfs/monthly/mls_2016/phylogeny/files/aa_ortholog_families_aligned/
# 2) Without outgroups:
cd /scratch/beegfs/monthly/mls_2016/phylogeny/files/aa_ortholog_families_aligned_woutgroup/

all_families=$( find family* )

cd /scratch/beegfs/monthly/mls_2016/phylogeny/files/phylogenetic_trees/aa_ML_noboot_gene_trees/all_families/

for family in $all_families; do
    mkdir $family
    cd /scratch/beegfs/monthly/mls_2016/phylogeny/files/phylogenetic_trees/aa_ML_noboot_gene_trees/all_families/$family
    # ML, no bootstrap, PROTGAMMAWAG
    raxmlHPC -m PROTGAMMAWAG -p 12345 -s \
    /scratch/beegfs/monthly/mls_2016/phylogeny/files/aa_ortholog_families_aligned/$family \
    -n $family$name
done