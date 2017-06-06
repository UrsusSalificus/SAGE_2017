#### Data subdirectory
Contain all the output of the analyses.
  
* `aa_ortholog_families_*` : directories containing the amino acid sequences of all 548 families in separate files,
    sequences which are either aligned or not. Depending on the analysis (`*`), each file in the directory contains 
    either 35 (`complete`), 27 (`woutgroup`) or 13 (`bees`) sequences.
* `dna_ortholog_families_*` : directories containing the nucleotides sequences of all 548 families in separate files,
    sequences which are either aligned (using their respective aligned amino acid sequences to preserve codons) or not.
    Each file in the directory contains 13 sequences.
* `phylogenetic_trees` : directory containing all the different directories and results of RAxML analyses. 
* `*_orthologs_only` : indexes of all the 548 families in a single files. Depending on the analysis (`*`), each file 
    contains either 35 (`complete`), 27 (`woutgroup`) or 13 (`bees`) indexes/members.
* `concatanated_*` : supermatrix = all the 548 sequences - of each genome - of either amino acid or dna - concatenated
    into one big sequence. Depending on the analysis (`*`), each file contains either 35 (`complete`), 27 (`woutgroup`) 
    or 13 (`bees`) lines/genomes.
