# Preparing aligned DNA sequences from aligned amino acid sequences
from Bio.Alphabet import IUPAC
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Align import MultipleSeqAlignment
from Bio import codonalign


concatanted_orthologs = "concatanated_aligned_orthologs"

with open(concatanted_orthologs, 'r') as concat_ortho:
    records = SeqIO.parse(concat_ortho, "fasta")
    sequences = []
    for each_species in records:
        sequences.append(SeqRecord(each_species.seq))

aln = MultipleSeqAlignment(sequences)
for records in aln:
    print(records.seq)

# TO FINISH


