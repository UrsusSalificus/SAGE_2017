from Bio import SeqIO

# Will take out all the genomes of species not in bees
to_take_out=['Hon2', 'Bin4', 'Ljoh', 'Lgas', 'Ldel', 'Lkef', 'Lhel', 'Lamy', 'Laci']

to_purge_file = "../files/concatanated_DNA_aligned_orthologs_by_aa"
purged_file = "../files/bee_only_concatanated_DNA_aligned_orthologs_by_aa"

# Will purge the concatanated sequences of these unwanted genomes
with open(to_purge_file, 'r') as input:
    aa_records = SeqIO.parse(input, "fasta")
    kept = []
    for each_record in aa_records:
        if each_record.id not in to_take_out:
            kept.append(each_record)
    with open (purged_file, 'w') as outfile:
        for each_sequence in kept:
            index = ">" + str(each_sequence.id) + "\n"
            outfile.write(index)
            sequence = str(each_sequence.seq) + "\n"
            outfile.write(sequence)
