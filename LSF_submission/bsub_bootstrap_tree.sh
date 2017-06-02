#!/usr/bin/env bash

# To use : bsub < ./bsub_bootstrap_tree.sh
# Will use multithread on same host (-n = number of cores, -R = same host)


#BSUB -L /bin/bash
#BSUB -e error_RAxML.txt
#BSUB -J RAxML
#BSUB -n 64
#BSUB -M 10485760

module add Phylogeny/raxml/8.2.9;

out_folder=$'/scratch/beegfs/monthly/mls_2016/phylogeny/files/phylogenetic_trees/aa_ML_bootstrap_woutgroup/'
if [ ! -d "$out_folder" ]; then
  mkdir $out_folder
fi
cd $out_folder

# Copy the concatanated amino acid squences (without outgroups) in the folder.
cp /scratch/beegfs/monthly/mls_2016/phylogeny/files/concatanated_aa_aligned_orthologs_woutgroup .

# ML,  bootstrap
raxmlHPC -m PROTGAMMAWAG -x 12345 -p 12345 -s concatanated_aa_aligned_orthologs_woutgroup -# 500 -n ML_bootstrap_woutgroup
