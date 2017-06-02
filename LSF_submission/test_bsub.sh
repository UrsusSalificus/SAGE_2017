#!/usr/bin/env bash

# To use : bsub < ./bsub_nobootstrap_only_bee.sh

#BSUB -L /bin/bash
#BSUB -e error_test.txt
#BSUB -J test
#BSUB -n 64
#BSUB -M 10485760

bsub -w "done(job_1) && done(job_2) && done(job_3)" wrapup

