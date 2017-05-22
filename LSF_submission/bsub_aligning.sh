#!/usr/bin/env bash

# To use : bsub < ./bsub_aligning.sh
# Will use multithread on same host (-n = number of cores, -R = same host)

#BSUB -L /bin/bash
#BSUB -e error_MAFFT.txt
#BSUB -J MAFFT
#BSUB -n 4
#BSUB –R "span[ptile=4]"
#BSUB -M 10485760
#BSUB –R "rusage[mem=10240]"

module add SequenceAnalysis/MultipleSequenceAlignment/mafft/7.305;

# Move to the folder containing all the families one wants to align
cd /scratch/beegfs/monthly/mls_2016/phylogeny/files/DNA_ortholog_families_NOT_aligned/

for i in $( find family* ); do
    # Specifying where we want the aligned family
    mafft --auto $i > /scratch/beegfs/monthly/mls_2016/phylogeny/files/DNA_ortholog_families_aligned/$i
done



