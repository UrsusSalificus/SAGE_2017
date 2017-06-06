#!/usr/bin/env bash

### Will compute the whole analysis, using LSF jobs running one after the other, but focusing on bees (12 genomes)
# To use :
#   1) First change directory (cd) to the folder containing this script
#   2) bash all_analysis_bees.sh
# Average time taken at each operation indicated by []
# Total time: ~2 hours, 20 minutes

### Extracting orthologs:   [instant]
cd scripts
bsub < ./bsub_selecting_orthologs.sh

### Purging to have only bumble and honey bees + Laci as outgroup   [instant]
bsub -w "ended(ortho)" < ./bsub_purging_bees.sh

### Fetching dna and aa sequences:     [~3 minutes]
if [ -d "../temp/" ] ; then
    rm -r ../temp/
fi
bsub -w "ended(purging)" < ./bsub_fetching_sequences_bees.sh

### Aligning sequences:     [~12 minutes]
bsub -w "ended(fetch)" < ./bsub_aligning_bees.sh
bsub -w "ended(MAFFT)" < ./bsub_aa_to_dna.sh

### Concatenating in one file   [instant]
bsub -w "ended(aa_to_dna)" < ./bsub_concatenating_bees.sh

### ML tree bootstrapped    [5 minutes]
bsub -w "ended(concat)" < ./bsub_bootstrap_bees.sh
bsub -w "ended(concat)" < ./bsub_nobootstrap_bees.sh

### Get bootstrap support [instant]
bsub -w "ended(b_bootstrap)&&ended(b_noboot)" < ./bsub_support_bees.sh
# Supported bootstrap tree :  files/phylogenetic_trees/dna_nobootstrap_bees/RAxML_bipartitions.bees_boot_supported.tree

### Gene trees  [2 hours]
bsub -w "ended(b_support)" < ./bsub_gene_trees_bees.sh

### Concatenating in one file   [instant]
bsub -w "ended(b_gene)" < ./bsub_concat_gene_bees.sh

### Getting single gene trees support   [instant]
bsub -w "ended(b_concat_gene)" < ./bsub_support_gene_bees.sh
# Supported gene tree :  files/phylogenetic_trees/dna_nobootstrap_bees/RAxML_bipartitions.bees_gene_supported.tree

### Merging the two supports    [instant]
bsub -w "ended(b_concat_gene)" < ./bsub_merging_bees.sh
# Final tree : files/phylogenetic_trees/bees_merged_boot_gene.tree

