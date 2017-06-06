#!/usr/bin/env bash

# To use : bsub < ./bsub_support_bees.sh
# Will use multithread on same host (-n = number of cores, -R one the same node/host)

#BSUB -L /bin/bash
#BSUB -J b_support
#BSUB -e error_b_support.txt
#BSUB -n 4
#BSUB –R "span[hosts=1]"
#BSUB -M 40194304
#BSUB -R "rusage[mem=40000]"

module add Phylogeny/raxml/8.2.9;

cd ../files/phylogenetic_trees/dna_nobootstrap_bees

# If for any reason, no best tree was chosen, we have to select it ourselves
if [ ! -f "RAxML_bestTree.bees_nobootstrap" ] ; then
    # Find last lines | look for the 5th element (log-likelihood values) | sort all of them | take the last (max)
    best_LogL=$( grep 'written' RAxML_info.bees_nobootstrap | awk '{print $5}' | sort -n | tail -1 )
    # Check for the first tree with this log-likelihood value | take the identifier | take identifier number
    best_tree=$( grep -- $best_LogL RAxML_info.bees_nobootstrap | awk '{print $1}' | grep -m1 -Eo '[0-9]{1,4}' )
    # Create the bestTree
    cp RAxML_result.bees_nobootstrap.RUN.$best_tree RAxML_bestTree.bees_nobootstrap
fi


# Compute bootstrap support of "best tree":
 raxmlHPC -m GTRCAT -p 12345 -f b -t RAxML_bestTree.bees_nobootstrap \
 -z ../dna_bootstrap_bees/RAxML_bootstrap.bees_bootstrap -n bees_boot_supported.tree
