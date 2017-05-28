#!/usr/bin/env bash

# To use : bsub < ./bsub_best_model.sh
# Will use multithread on same host (-n = number of cores, -R = same host)

#BSUB -L /bin/bash
#BSUB -e error_prottest.txt
#BSUB -J prottest
#BSUB -n 4
#BSUB -M 10485760

module add Phylogeny/prottest/3.4.1;

# space + \ -> don't take into account the next \n
# Had to find where was added the module -> /software/Phylogeny/prottest/3.4.1/bin/

java -jar /software/Phylogeny/prottest/3.4.1/bin/prottest-3.4.1.jar \
    -i /scratch/beegfs/monthly/mls_2016/phylogeny/files/

for i in $( find /scratch/beegfs/monthly/mls_2016/phylogeny/files/ortholog_families_aligned/family* ); do
    name=$( echo $i | tr -s '/' '\n' | sed -n 9p ) # Will take only the family (end of the path)
    java -jar /software/Phylogeny/prottest/3.4.1/bin/prottest-3.4.1.jar \
    -i /scratch/beegfs/monthly/mls_2016/phylogeny/files/ortholog_families_aligned/$name \
    -o /scratch/beegfs/monthly/mls_2016/phylogeny/files/best_models/$name
done