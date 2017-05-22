## LSF cluster jobs
Scripts which must be placed elsewhere than the main `scripts` folder are marked with `*`.

Brief explanation of files found in this repo:

```
bsub_aligning.sh : aligning multiple files using MAFFT.
bsub_best_model.sh : finding the best evolutionary models for multiple alignements.
bsub_concatenating.sh : assigning python script concatenating_all_aligned.py as LSF job
bsub_fetching_dna.sh : assigning python script fetching_dna.py as LSF job
*bsub_bootstrap_tree.sh : computing 500 rapid-bootstrap ML tree of amino acid, using RAxML and PROTGAMMAWAG model
*bsub_nobootstrap_tree.sh : computing ML tree of amino acid, using RAxML and PROTGAMMAWAG model

```