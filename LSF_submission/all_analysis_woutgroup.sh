#!/usr/bin/env bash
# To use : bash all_analysis_woutgroup.sh

bsub < ./bsub_purging_after_fetch.sh
bsub -w "done(purging_after_fetch)" < ./bsub_aligning.sh
bsub -w "done(MAFFT)" < ./bsub_concatenating.sh
bsub -w "done(concat)" < ./bsub_bootstrap_tree.sh