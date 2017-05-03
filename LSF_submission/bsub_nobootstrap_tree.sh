#!/usr/bin/env bash

# To use : bsub < ./bsub_nobootstrap_tree.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Will

#BSUB -L /bin/bash
#BSUB -e error_RAxML.txt
#BSUB -J RAxML
#BSUB -n 4
#BSUB –R "span[ptile=4]"
#BSUB -M 10485760
#BSUB –R "rusage[mem=10240]"

module add Phylogeny/raxml/8.2.9;

# ML, no bootstrap
raxmlHPC -m PROTGAMMAWAG -p 12345 -s concatanated_aligned_orthologs -n ML_nobootstrap