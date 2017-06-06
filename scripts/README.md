#### Data subdirectory
Contain all the scripts needed to perform the analyses:

##### Python scripts
  
* `aa_to_DNA :` : will build a codon alignment from a protein alignment and corresponding nucleotide sequences.
* `concatenating_all_aligned.py` : will concatenate all the sequences of each species/strain
* `fetching_sequences.py` : will extract either nucleotide or amino acid sequences, from a list of orthologs.
* `merging_support.py` : will merge the support of either bootstrap or single gene tree in a single newick format tree.
* `orthologs_only.py` : will extract orthologs, from a list of homologous genes.
* `remove_genome.py` : will purge unwanted genomes from a file containing the 548 orthologous families 
* `simplify_names_gene_trees.py` : will concatenate all the single gene trees into one, and trim the gene names in the 
    indices.


##### LSF jobs

* `bsub_aa_to_dna.sh` : linked to `aa_to_DNA.py`
* `bsub_aligning_*.sh` : will align all individual files (each family) of unaligned sequences through `MAFFT`
* `bsub_bootstrap_*.sh` : will compute a ML bootstrap analysis of phylogenetic tree through `RAxML` 
* `bsub_concat_gene_*.sh` : linked to `simplify_names_gene_trees.py`
* `bsub_concatenating_*.sh` : linked to `concatenating_all_aligned.py`
* `bsub_fetching_sequences_*.sh` : linked to `fetching_sequences.py` 
* `bsub_gene_trees_*.sh` : will compute 548 phylogenetic trees through `RAxML`  
* `bsub_merging_*.sh` : linked to `merging_support.py`  
* `bsub_nobootstrap_*.sh` : will compute a ML analysis of phylogenetic tree through `RAxML` 
* `bsub_purging_*.sh` : linked to `remove_genome.py`
* `bsub_selecting_orthologs.sh` : linked to `orthologs_only.py`
* `bsub_support_*.sh` : will extract the bootstrap support out of concatenated file of bootstrap trees through `RAxML` 
* `bsub_support_gene_*.sh` :  will extract the single gene tree support out of concatenated file of 
    single gene trees through `RAxML`
