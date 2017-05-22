#!/usr/bin/env bash

# To use : bsub < ./bsub_fetching_dna.sh
# Will use multithread on same host (-n = number of cores, -R = same host)

#BSUB -L /bin/bash
#BSUB -e error_fetch.txt
#BSUB -J fetch
#BSUB -n 4
#BSUB –R "span[ptile=4]"
#BSUB -M 10485760
#BSUB –R "rusage[mem=10240]"

python3 fetching_dna.py