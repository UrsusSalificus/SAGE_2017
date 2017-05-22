## SAGE course 2017: Core phylogeny
Sequence A GEnome (SAGE) course  is taking place at Lausanne University (Swiss) and involves sequencing and analyzing a bacterial genome.
This year course focuses on the bumble and honey bees gut-microbiota, more precisely on Firm-5 strain.
This Repo contains all the scripts used to perform the core phylogeny on the different strains found.  

Brief explanation of files found in this repo:

```
aa_to_DNA : will build a codon alignment from a protein alignment and corresponding nucleotide sequences
orthologs_only.py : will extract orthologs, from a list of homologous genes.
to_have_test_homolog.sh : simple reminder of how to create a test file from bigger file.
fetching_aa.py : will extract amino acid sequences, from a list of orthologs.
fetching_dna.py : will extract nucleotides sequences, from a list of orthologs.
concatenating_all_aligned.py : will concatenate all the sequences of each species/strain
LSF_submission : contains all the bsub (cluster jobs)

```