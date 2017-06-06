#!/usr/bin/env bash

# To use : bsub < ./bsub_fetching_sequences_bees.sh
# Will use multithread on 2 hosts (-n = number of cores, -R = same host)
# NOTE: fetching_sequences.py uses 14 core to parallel, if you change the BSUB setting, change it also in the .py!
# (Under the definition of the function 'to_parallel' -> '(n_jobs=14)')
# Takes about 3 minutes to complete


#BSUB -L /bin/bash
#BSUB -e error_fetch.txt
#BSUB -J fetch
#BSUB -n 32
#BSUB –R "span[ptile=16]"
#BSUB -M 10485760

# Check where we are to come back later on:
way_back=$( pwd )

# We must know the number of families beforehand:
ortholog_file=$'../files/bees_orthologs_only'
all_families=$( less $ortholog_file | wc -l )
all_families_range=$( seq 1 1 $all_families )

mkdir ../files/aa_ortholog_families_NOT_aligned_bees/
cd ../files/aa_ortholog_families_NOT_aligned_bees/
# Create l empty files (where l = number of families) in the fetched sequences directory -> for the python script later
for i in $all_families_range; do
    > family_$i
done

mkdir ../dna_ortholog_families_NOT_aligned_bees/
cd ../dna_ortholog_families_NOT_aligned_bees/
# Create l empty files (where l = number of families) in the fetched sequences directory -> for the python script later
for i in $all_families_range; do
    > family_$i
done

cd $way_back

# Will use a temp directory to store the files in the python script, thus have to create it first
if [ ! -d "../temp/" ] ; then
    mkdir ../temp/
fi

python3 fetching_sequences.py .faa ../files/aa_ortholog_families_NOT_aligned_bees/ $ortholog_file
python3 fetching_sequences.py .ffn ../files/dna_ortholog_families_NOT_aligned_bees/ $ortholog_file

