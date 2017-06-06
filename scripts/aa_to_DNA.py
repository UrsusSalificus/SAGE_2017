# Aligning DNA sequences from aligned amino acid sequences
from Bio.Alphabet import IUPAC
from Bio import SeqIO
from Bio.Align import MultipleSeqAlignment
from Bio import codonalign
import glob

# Path to the input directory containing the aligned families of amino acid sequences:
aligned_aa_files_directory = "../files/aa_ortholog_families_aligned_bees/"
# Path to the input directory containing the unaligned families of nucleotide sequences:
unaligned_dna_files_directory = "../files/dna_ortholog_families_NOT_aligned_bees/"
# Path to the output directory which will contain the aligned families of nucleotide sequences:
aligned_dna_files_directory = "../files/dna_ortholog_families_aligned_bees/"

###
# Extract the families to translate the different codes
###
def fetch_the_families (aligned_aa_files_directory):
    all_families = glob.glob(aligned_aa_files_directory + "family*")
    list_each_family = []
    # We only want the "family_i", so will split and take the last one of the path ([-1])
    for each_family in all_families:
        list_each_family.append(each_family.split('/')[-1])
    return(list_each_family)

###
# For each family of orthologs, fetch the aligned amino acid and unaligned dna sequences of each members (= each genes)
# Inputs:
#   - aligned_aa_files_directory: path to the directory containing all the aligned amino acid sequences
#   - unaligned_dna_files_directory: path to the directory containing all the unaligned nucleotide sequences
#   - aligned_dna_files_directory: path to the output directory which will
#       contain the aligned families of nucleotide sequences
#   -families: list of the families names, obtained through fetch_the_families function
# Output:
#   - n files (where n = number of families) containing each l sequences (where l = number of members in the family)
###
def aligned_using_aa (aligned_aa_files_directory, unaligned_dna_files_directory,
                      aligned_dna_files_directory, families):
    for each_family in families:
        # First prepare all the individual family paths (path + family_i)
        aa_file = aligned_aa_files_directory + str(each_family)
        dna_unaligned_file = unaligned_dna_files_directory + str(each_family)
        dna_aligned_file = aligned_dna_files_directory + str(each_family)

        # Now open the family_i aligned aa and unaligned dna.
        with open(aa_file, 'r') as family_aa, \
                open(dna_unaligned_file, 'r') as family_dna:
            # We will use already aligned aa, it thus require additional steps than otherwise
            # Prepare an empty aa alignement format required by codonalign
            aligned_aa = MultipleSeqAlignment([])

            # Read using a specific alphabet (also required for codonalign)
            aa_records = SeqIO.parse(family_aa, "fasta", alphabet=IUPAC.protein)
            dna_records = SeqIO.parse(family_dna, "fasta", alphabet=IUPAC.IUPACUnambiguousDNA())

            # Fill the empty alignement format prepared before
            for each_species in aa_records:
                aligned_aa.append(each_species)

            # Align each sequence using this aligned aa sequences (no need for 'for' loops -> parse all list
            # one by one)
            aligned_dna = codonalign.build(aligned_aa, dna_records)

        # Can now write, adding missing newline and index prefixes (>)
        with open(dna_aligned_file, 'w') as outfile:
            for each_sequence in aligned_dna:
                index = ">" + str(each_sequence.id) + "\n"
                outfile.write(index)
                sequence = str(each_sequence.seq) + "\n"
                outfile.write(sequence)


families = fetch_the_families(aligned_aa_files_directory = aligned_aa_files_directory)
aligned_using_aa(aligned_aa_files_directory = aligned_aa_files_directory,
                 unaligned_dna_files_directory = unaligned_dna_files_directory,
                 aligned_dna_files_directory = aligned_dna_files_directory, families = families)
