from Bio import SeqIO
import glob
import os

# Path to the directory containing the reduced codes for the genomes:
codes_for_genomes = "../files/woutgroup_file_list"
# Path to the directory which contain the families to purge
family_directory="../files/aa_ortholog_families_NOT_aligned/"  # For amino acid
#family_directory="../files/DNA_ortholog_families_NOT_aligned/"  # For DNA
# Path to the directory which will contain the purged families
#purged_family_directory="../files/aa_ortholog_families_NOT_aligned_bee_only/" # For amino acid
#purged_family_directory="../files/DNA_ortholog_families_NOT_aligned_bee_only/" # For DNA
purged_family_directory="../files/aa_ortholog_families_NOT_aligned_woutgroup/" # For DNA



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

dico = extract_translation(codes_for_genomes = codes_for_genomes)

###
# Extract the genomes used when looking for homologs
###
def extract_genomes(family_directory):
    return (glob.glob(family_directory + "family*"))
to_purge_files = extract_genomes(family_directory = family_directory)

if not os.path.exists(purged_family_directory):
    os.makedirs(purged_family_directory)
for each_family in to_purge_files:
    family = each_family.split('/')[3]
    purged_family = purged_family_directory + family
    with open(each_family, 'r') as input, open (purged_family, 'w') as outfile:
        aa_records = SeqIO.parse(input, "fasta")
        kept = []
        for each_record in aa_records:
            if each_record.id.split('|')[0] in dico.keys():
                kept.append(each_record)
        for each_sequence in kept:
            index = ">" + str(each_sequence.id) + "\n"
            outfile.write(index)
            sequence = str(each_sequence.seq) + "\n"
            outfile.write(sequence)

