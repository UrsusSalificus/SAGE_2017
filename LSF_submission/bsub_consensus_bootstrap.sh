#!/usr/bin/env bash

# To use : bsub < ./bsub_consensus_bootstrap.sh
# Will use multithread on same host (-n = number of cores, -R = same host)

#BSUB -L /bin/bash
#BSUB -e error_consensus.txt
#BSUB -J consensus
#BSUB -n 64
#BSUB -M 10485760

module add Phylogeny/raxml/8.2.9;

cd /scratch/beegfs/monthly/mls_2016/phylogeny/files/phylogenetic_trees/aa_ML_noboot_gene_trees/

most_likely_tree=$'/scratch/beegfs/monthly/mls_2016/phylogeny/files/phylogenetic_trees/aa_ML_nobootstrap_tree/RAxML_result.ML_nobootstrap.tree'
supporting_tree=$'/scratch/beegfs/monthly/mls_2016/phylogeny/files/phylogenetic_trees/aa_ML_noboot_gene_trees/cleaned_concat_all_gene_trees'

# Different consensus can be computed:
# Bipartition, need a "scaffold", then support it with the bootstraps:
#raxmlHPC -m GTRCAT -p 12345 -f b -t $most_likely_tree -z $supporting_tree -n bipartition_gene

# Majority consensus:
raxmlHPC -m GTRCAT -J MR -z $supporting_tree -n majority