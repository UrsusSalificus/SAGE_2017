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
bsub -w "ended(concat)" < ./bsub_bootstrap_complete.sh

### WARNING ###
# This part as not been tested and must be tweaked to properly work.



