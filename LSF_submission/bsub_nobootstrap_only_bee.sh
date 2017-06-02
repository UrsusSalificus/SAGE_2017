#!/usr/bin/env bash

# To use : bsub < ./bsub_nobootstrap_only_bee.sh
# Will use multithread on same host (-n = number of cores, -R = same host)

#BSUB -L /bin/bash
#BSUB -e error_RAxML.txt
#BSUB -J RAxML
#BSUB -n 64
#BSUB -M 10485760

module add Phylogeny/raxml/8.2.9;

out_folder=$'/scratch/beegfs/monthly/mls_2016/phylogeny/files/phylogenetic_trees/dna_ML_noboot_bee_only/'
if [ ! -d "$out_folder" ]; then
  mkdir $out_folder
fi
cd $out_folder

# ML, no bootstrap, GTRGAMMA
raxmlHPC -m GTRGAMMA -p 12345 -s concatanated_DNA_aligned_orthologs_by_aa_bee_only -n ML_nobootstrap_only_bee