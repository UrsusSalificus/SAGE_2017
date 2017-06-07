#!/usr/bin/env bash

### Will compute the whole analysis, using LSF jobs running one after the other, on the 35 genomes.
# To use :
#   1) First change directory (cd) to the folder containing this script
#   2) bash all_analysis_all_genomes.sh
# Average time taken at each operation indicated by []
# We weren't able to finalize this analysis, due to parallelization and LSF queues issues (job taking to long
# on the normal queue).
# TODO: try different settings of the Hybrid version of RAxML and with the 'long' queue (= less cores per job !)

### Extracting orthologs:   [instant]
cd scripts
bsub < ./bsub_selecting_orthologs.sh

### Fetching sequences:     [~3 minutes]
if [ -d "../temp/" ] ; then
    rm -r ../temp/
fi
bsub -w "ended(ortho)" < ./bsub_fetching_sequences_complete.sh

### Aligning sequences:     [~10 minutes]
bsub -w "ended(fetch)" < ./bsub_aligning_complete.sh

### Concatenating in one file   [instant]
bsub -w "ended(MAFFT)" < ./bsub_concatenating_complete.sh

### ML tree no bootstrap    []
bsub -w "ended(concat)" < ./bsub_nobootstrap_complete.sh

### WARNING ###
# This part as not been tested and must be tweaked to properly work.
# It may also require to be split in multiple part (like in woutgroup analysis)

### ML tree bootstrapped   []
#bsub -w "ended(c_noboot)" < ./bsub_bootstrap_complete.sh

### Get support []
#bsub -w "ended(c_bootstrap)" < ./bsub_support_complete.sh
# Supported tree :  files/phylogenetic_trees/aa_nobootstrap_complete/RAxML_bipartitions.complete_boot_supported.tree

### Gene trees  []
#bsub -w "ended(c_support)" < ./bsub_gene_trees_complete.sh

### Concatenating in one file   []
#bsub -w "ended(c_gene)" < ./bsub_concat_gene_complete.sh

### Getting single gene trees support   []
#bsub -w "ended(c_concat_gene)" < ./bsub_support_gene_complete.sh
# Supported gene tree :  files/phylogenetic_trees/aa_nobootstrap_complete/RAxML_bipartitions.complete_gene_supported.tree

### Merging the two supports    []
#bsub -w "ended(c_support_gene)" < ./bsub_merging_complete.sh
# Final tree : files/phylogenetic_trees/complete_merged_boot_gene.tree