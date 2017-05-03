#!/usr/bin/env bash

# To use : bsub < ./bsub_aligning.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Will

#BSUB -L /bin/bash
#BSUB -e error_MAFFT.txt
#BSUB -J MAFFT
#BSUB -n 4
#BSUB –R "span[ptile=4]"
#BSUB -M 10485760
#BSUB –R "rusage[mem=10240]"

module add SequenceAnalysis/MultipleSequenceAlignment/mafft/7.305;

for i in $( find family* ); do
    echo $i > lol.txt
    #mafft --auto $i > /scratch/beegfs/monthly/mls_2016/phylogeny/files/ortholog_families_aligned/$i
done