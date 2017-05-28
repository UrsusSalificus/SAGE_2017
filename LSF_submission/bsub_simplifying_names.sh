#!/usr/bin/env bash

# To use : bsub < ./bsub_simplifying_names.sh
# Will use multithread on same host (-n = number of cores, -R = same host)
# Takes approximately 10 sec for the 548 trees.

#BSUB -L /bin/bash
#BSUB -e error_simplify.txt
#BSUB -J simplify
#BSUB -n 8
#BSUB -M 10485760

python3 simplify_names_gene_trees.py