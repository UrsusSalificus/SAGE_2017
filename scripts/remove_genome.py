import sys

# Path to the directory containing the file to purge
to_purge_file = "../files/orthologs_only"
# Path to the directory containing the codes for the genomes:
codes_for_genomes = sys.argv[1]
# Path to the directory containing the file to purge
purged_file = sys.argv[2]

###s
# Extract the indices to translate the different codes
###
def extract_translation (codes_for_genomes):
    translation = {}
    with open(codes_for_genomes, 'r') as codes:
        # We want to skip the first line (headers), thus make it a iterable object, and jumping first one
        codes = iter(codes)
        next(codes)
        for line in codes:
            splitted = line.split()
            print(splitted)
            # Here, will take the third column (OrthoMCL_prefix column) as keys
            # And the second column (Strain_prefix) as value
            translation[splitted[2]] = splitted[1]
    return(translation)

# Will purge the concatanated sequences of these unwanted genomes
def purge_file(to_purge_file, purged_file, dico):
    with open(to_purge_file, 'r') as input, open (purged_file, 'w') as outfile:
        for each_family in input:
            splitted_family = each_family.split()
            for each_member in splitted_family:
                # If it is in the dico -> kept, otherwise, passed.
                if each_member.split('|')[0] in dico.keys():
                    outfile.write(each_member + '\t')
            outfile.write('\n')

dico = extract_translation(codes_for_genomes = codes_for_genomes)
purge_file(to_purge_file = to_purge_file, purged_file = purged_file, dico = dico)