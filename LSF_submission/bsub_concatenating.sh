#!/usr/bin/env bash

# To use : bsub < ./bsub_concatenating.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Takes approximately 10 sec for the 548 families.

#BSUB -L /bin/bash
#BSUB -e error_concat.txt
#BSUB -J concat
#BSUB -n 20
#BSUB -M 10485760

python3 concatenating_all_aligned.py