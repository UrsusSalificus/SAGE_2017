#!/usr/bin/env bash

# To use : bsub < ./bsub_concatenating.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Will

#BSUB -L /bin/bash
#BSUB -e error_concat.txt
#BSUB -J concat
#BSUB -n 4
#BSUB –R "span[ptile=4]"
#BSUB -M 10485760
#BSUB –R "rusage[mem=10240]"

python3 concatenating_all_aligned.py