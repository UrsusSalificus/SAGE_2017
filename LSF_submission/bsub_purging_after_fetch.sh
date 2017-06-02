#!/usr/bin/env bash

# To use : bsub < ./bsub_purging_after_fetch.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Takes approximately ???

#BSUB -L /bin/bash
#BSUB -e error_purging_after_fetch.txt
#BSUB -J purging_after_fetch
#BSUB -n 64
#BSUB -M 10485760

python3 remove_genome_after_fetched.py



