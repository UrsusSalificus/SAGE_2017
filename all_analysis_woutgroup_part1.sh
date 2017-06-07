#!/usr/bin/env bash

### Will compute the whole analysis, using LSF jobs running one after the other, but without the outgroups (27 genomes)
# PLEASE, compute Part 1 first, then wait for it to finish before launching part 2
# LSF may kill the pending jobs otherwise.
# To use :
#   1) First change directory (cd) to the folder containing this script
#   2) bash all_analysis_woutgroup_part1.sh
# Average time taken at each operation indicated by []
# Total time of part 1:

### Extracting orthologs:   [instant]
cd scripts
bsub < ./bsub_selecting_orthologs.sh

### Purging to have only bumble and honey bees + Laci as outgroup   [instant]
bsub -w "ended(ortho)" < ./bsub_purging_woutgroup.sh

### Fetching aa sequences:     [~3 minutes]
if [ -d "../temp/" ] ; then
    rm -r ../temp/
fi
bsub -w "ended(purging)" < ./bsub_fetching_sequences_woutgroup.sh

### Aligning sequences:     [~10 minutes]
bsub -w "ended(fetch)" < ./bsub_aligning_woutgroup.sh

### Concatenating in one file   [instant]
bsub -w "ended(MAFFT)" < ./bsub_concatenating_woutgroup.sh

### ML tree bootstrapped  & ML best tree  [~19 hours]
bsub -w "ended(concat)" < ./bsub_bootstrap_woutgroup.sh
bsub -w "ended(concat)" < ./bsub_nobootstrap_woutgroup.sh

### Get support [instant]
bsub -w "ended(w_bootstrap)&&ended(w_noboot)" < ./bsub_support_woutgroup.sh
# Supported bootstrap tree :  files/phylogenetic_trees/aa_nobootstrap_woutgroup/RAxML_bipartitions.woutgroup_boot_supported.tree






