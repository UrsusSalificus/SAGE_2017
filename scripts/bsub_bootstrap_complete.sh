#!/usr/bin/env bash

# To use : bsub < ./bsub_bootstrap_complete.sh
# Will use multithread on same host (-n = number of cores, -R one the same node/host)

#BSUB -L /bin/bash
#BSUB -J complete_bootstrap
#BSUB -e error_%J.txt
#BSUB -n 64
#BSUB –R "span[ptile=64]"
#BSUB -M 40194304
#BSUB -R "rusage[mem=40000]"

module add Phylogeny/raxml/8.2.9;
if [ ! -d "../files/phylogenetic_trees/aa_bootstrap_complete/" ] ; then
   mkdir ../files/phylogenetic_trees/aa_bootstrap_complete
fi
cd ../files/phylogenetic_trees/aa_bootstrap_complete

# ML,  bootstrap
# "Rule of thumb, one core for 500 distinct pattern"
# We have 82'000 distinct pattern = need max core available (would need 164)
# We will use the hybrid parallel version, which do both MPI and multi-threading
# We compute less threads (-T) that there is available cores in the node to avoid any problem
# We will let RAxML decide how many bootstrap it needs by setting -N autoMRE
raxmlHPC-HYBRID -m PROTGAMMAWAG -x 12345 -p 12345 -s ../../concatanated_aa_aligned_orthologs \
 -N autoMRE -n complete_bootstrap -T 58 ­­set­thread­affinity
