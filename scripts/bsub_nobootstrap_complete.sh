#!/usr/bin/env bash

# To use : bsub < ./bsub_nobootstrap_complete.sh
# Will use multithread on same host (-n = number of cores, -R one the same node/host)

#BSUB -L /bin/bash
#BSUB -J c_noboot
#BSUB -e error_c_noboot.txt
#BSUB -n 64
#BSUB –R "span[hosts=1]"
#BSUB -M 40194304
#BSUB -R "rusage[mem=40000]"

module add Phylogeny/raxml/8.2.9;
if [ ! -d "../files/phylogenetic_trees/aa_nobootstrap_complete/" ] ; then
   mkdir ../files/phylogenetic_trees/aa_nobootstrap_complete
fi
cd ../files/phylogenetic_trees/aa_nobootstrap_complete

# ML,  no bootstrap
# "Rule of thumb, one core for 500 distinct pattern"
# We have 82'000 distinct pattern = need max core available (would need 164)
# We will use the hybrid parallel version, which do both MPI and multi-threading
# We compute less threads (-T) that there is available cores in the node to avoid any problems
raxmlHPC-HYBRID -m PROTGAMMAWAG -p 12345 -s ../../concatanated_aa_aligned_orthologs_complete \
 -N 20 -n woutgroup_nobootstrap -T 58 ­­set­thread­affinity
