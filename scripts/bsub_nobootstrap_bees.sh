#!/usr/bin/env bash

# To use : bsub < ./bsub_nobootstrap_bees.sh
# Will use multithread on same host (-n = number of cores, -R one the same node/host)

#BSUB -L /bin/bash
#BSUB -J b_noboot
#BSUB -e error_b_noboot.txt
#BSUB -n 12
#BSUB –R "span[hosts=1]"
#BSUB -M 40194304
#BSUB -R "rusage[mem=40000]"

module add Phylogeny/raxml/8.2.9;
if [ ! -d "../files/phylogenetic_trees/dna_nobootstrap_bees/" ] ; then
   mkdir ../files/phylogenetic_trees/dna_nobootstrap_bees
fi
cd ../files/phylogenetic_trees/dna_nobootstrap_bees

# ML,  bootstrap
# "Rule of thumb, one core for 500 distinct pattern"
# We have ~3'700 distinct pattern = need no more than 8 cores
# We will use the hybrid parallel version, which do both MPI and multi-threading
# We compute less threads (-T) that there is available cores in the node to avoid any problem
raxmlHPC-HYBRID -m GTRGAMMA -p 12345 -s ../../concatanated_dna_aligned_orthologs_bees \
 -N 20 -n bees_nobootstrap -T 8 ­­set­thread­affinity
