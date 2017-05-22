#!/usr/bin/env bash

# To use : bsub < ./bsub_bootstrap_tree.sh
# Will use multithread on same host (-n = number of cores, -R = same host)


#BSUB -L /bin/bash
#BSUB -e error_RAxML.txt
#BSUB -J RAxML
#BSUB -n 4
#BSUB -M 10485760

module add Phylogeny/raxml/8.2.9;

# ML,  bootstrap
raxmlHPC -m PROTGAMMAWAG -x 12345 -p 12345 -s concatanated_aligned_orthologs_woutgroups -# 500 -n ML_bootstrap
