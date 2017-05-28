#!/usr/bin/env bash

# To use : bsub < ./bsub_nobootstrap_only_bee.sh
# Will use multithread on same host (-n = number of cores, -R = same host)

#BSUB -L /bin/bash
#BSUB -e error_RAxML.txt
#BSUB -J RAxML
#BSUB -n 50
#BSUB -M 10485760

module add Phylogeny/raxml/8.2.9;

# ML, no bootstrap, GTRGAMMA
raxmlHPC -m GTRGAMMA -p 12345 -s ../files/bee_only_concatanated_DNA_aligned_orthologs_by_aa -n ML_nobootstrap_only_bee