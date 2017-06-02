#!/usr/bin/env bash

# To use : bsub < ./bsub_fetching_dna.sh
# Will use multithread on same host (-n = number of cores, -R = same host)

#BSUB -L /bin/bash
#BSUB -e error_fetch_aa.txt
#BSUB -J fetch_aa
#BSUB -n 64
#BSUB -M 10485760

python3 fetching_dna.py