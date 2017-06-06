#!/usr/bin/env bash

# To use : bsub < ./bsub_bootstrap_bees.sh
# Will use multithread on same host (-n = number of cores, -R one the same node/host)

#BSUB -L /bin/bash
#BSUB -J b_bootstrap
#BSUB -e error_b_bootstrap.txt
#BSUB -n 12
#BSUB –R "span[hosts=1]"
#BSUB -M 40194304
#BSUB -R "rusage[mem=40000]"

module add Phylogeny/raxml/8.2.9;
if [ ! -d "../files/phylogenetic_trees/dna_bootstrap_bees/" ] ; then
   mkdir ../files/phylogenetic_trees/dna_bootstrap_bees
fi
cd ../files/phylogenetic_trees/dna_bootstrap_bees

# ML,  bootstrap
# "Rule of thumb, one core for 500 distinct pattern"
# We have ~3'700 distinct pattern = need no more than 8 cores
# We will use the hybrid parallel version, which do both MPI and multi-threading
# We compute less threads (-T) that there is available cores in the node to avoid any problem
# We will let RAxML decide how many bootstrap it needs by setting -N autoMRE
raxmlHPC-HYBRID -m GTRGAMMA -x 12345 -p 12345 -s ../../concatanated_dna_aligned_orthologs_bees \
 -N autoMRE -n bees_bootstrap -T 8 ­­set­thread­affinity
