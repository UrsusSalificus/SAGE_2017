# To concatenate all the different members/sequences for each species/strain

from Bio import SeqIO
import glob

# Path to the directory containing all the orthologs families with aligned members/sequences
aligned_files_directory = "../files/ortholog_families_aligned/"
# Path to the directory containing the codes for the genomes:
codes_for_genomes = "../../genome_files/file_list"
# Path/name of the wanted output file
newfile = "../files/concatanated_aligned_orthologs"


###
# Extract all the path to all families
###
def extract_aligned_files(aligned_files_directory):
    return (glob.glob(aligned_files_directory + "family*"))

###
# Extract the indices to translate the different codes
###
def extract_translation (codes_for_genomes):
    translation = {}
    with open(codes_for_genomes, 'r') as codes:
        for line in codes:
            splitted = line.split()
            # Here, will take the third column (OrthoMCL_prefix column) as keys
            # And the second column (Strain_prefix) as value
            translation[splitted[2]] = splitted[1]
    return(translation)

###
# Extract the number of members/sequences and the species/strain name of the members/sequences
###
def extract_information(aligned_file_list, dico):
    # Will look into a random file containg the aligned sequences of a family
    with open(aligned_file_list[0], 'r') as example_family:
        # Extract the header (in the right order)
        records = list(SeqIO.parse(example_family, "fasta"))
        number_sequences = len(records)
        species_names = []
        # For each header, translate it to species/strain name
        for each_line in records:
            species_names += [dico[each_line.id.split('|')[0]]]
        info = [number_sequences, species_names]
    return info

###
# Concatenate all the different members/sequences for each species/strain into one fasta file
###
def concatenate_each_member(aligned_file_list, info, newfile):
    # Constructing list will contain n strings (Where n = number of members/sequences)
    constructing_list = [''] * info[0]
    for each_file in aligned_file_list:
        with open(each_file, 'r') as each_family:
            seq_records = SeqIO.parse(each_family, 'fasta')
            # i will be used to keep track of at which member/sequence we are
            i = 0
            for each_member in seq_records:
                # For each member, in each family, we extract the sequence and concatenate to the i string
                constructing_list[i] += str(each_member.seq)
                i += 1

    with open(newfile, 'w') as outfile:
        # i will here also be used to keep track of at which member/sequence we are
        i = 0
        for each_member in constructing_list:
            # Header are constructed using the i species/strain name + newline
            header = '>' + info[1][i] + '\n'
            outfile.write(header + each_member + '\n')
            i += 1

aligned_file_list = extract_aligned_files(aligned_files_directory = aligned_files_directory)
dico = extract_translation(codes_for_genomes=codes_for_genomes)
info = extract_information(aligned_file_list = aligned_file_list, dico = dico)
concatenate_each_member(aligned_file_list = aligned_file_list, info = info, newfile = newfile)


