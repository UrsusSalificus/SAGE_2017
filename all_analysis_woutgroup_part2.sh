#!/usr/bin/env bash

### Will compute the whole analysis, using LSF jobs running one after the other, but without the outgroups (27 genomes)
# PLEASE, compute Part 1 first, then wait for it to finish before launching part 2
# LSF may kill the pending jobs otherwise.
# To use :
#   1) First change directory (cd) to the folder containing this script
#   2) bash all_analysis_woutgroup_part2.sh
# Average time taken at each operation indicated by []
# Total time of part 2: 30 hours

### Gene trees  [30 hours = 1 days, 6 hours]
bsub < ./bsub_gene_trees_woutgroup.sh

### Concatenating in one file   [1 minute]
bsub -w "ended(w_gene)" < ./bsub_concat_gene_woutgroup.sh

### Getting single gene trees support   [instant]
bsub -w "ended(w_concat_gene)" < ./bsub_support_gene_woutgroup.sh
# Supported gene tree :  files/phylogenetic_trees/aa_nobootstrap_woutgroup/RAxML_bipartitions.woutgroup_gene_supported.tree

### Merging the two supports    [instant]
bsub -w "ended(w_support_gene)" < ./bsub_merging_woutgroup.sh
# Final tree : files/phylogenetic_trees/woutgroup_merged_boot_gene.tree





