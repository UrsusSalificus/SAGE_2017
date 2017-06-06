#!/usr/bin/env bash

# To use : bsub < ./bsub_purging_bees.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Takes approximately 10 sec

#BSUB -L /bin/bash
#BSUB -e error_purging.txt
#BSUB -J purging
#BSUB -n 4
#BSUB -M 10485760

python3 remove_genome.py ../data/bees_file_list ../files/bees_orthologs_only



