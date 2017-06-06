#!/usr/bin/env bash

# To use : bsub < ./bsub_selecting_orthologs.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Takes about 10 seconds to complete

#BSUB -L /bin/bash
#BSUB -e error_ortho.txt
#BSUB -J ortho
#BSUB -n 4
#BSUB –R "span[ptile=4]"
#BSUB -M 10485760

python3 orthologs_only.py
