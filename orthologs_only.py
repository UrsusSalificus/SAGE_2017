# To extract orthologs from a list of homologs:

import glob
# import sys  # Used for sys.arg, but in induces permission error...

# Path to the directory containing all the genomes:
genomes_directory = "../../genome_files/"
# Path to the input file (here the list of all homologs)
oldfile = "../files/mclOutput"
# Path to the output file (here the list of all the orthologs only)
newfile = "../files/orthologs_only"

###
# Extract the genomes used when looking for homologs
###
def extract_genomes(path):
    return (glob.glob(path + "*.faa"))

genomes = extract_genomes(path = genomes_directory)



###
# Filter homolog list into list of orthologs only
# Read a list of families, then keep if the number of genes in the family
# equal the number of different genomes used to construct the homolog table,
# then if it is equal, check if there is no dupplicate.
# Keep all the families that pass both requirements family of orthologs only.
# inputs:
#   oldfile: Path to the input file (here the list of all homologs)
#   newfile: Path to the output file (here the list of all the orthologs only)
#   genomes: Genomes used to create the homolog list
###
def filter(oldfile, newfile, genomes):
    # First open the output file in writing mode as 'outfile',
    # Then open the input file in reading mode as 'infile'
    with open(newfile, 'w') as outfile, open(oldfile, 'r') as infile:
        # For each line (=each homolog family), split to have each members separated
        # (split() does the job as they are separated by \t)
        for line in infile:
            splitted = line.split()
            # Check if the number of members in the family equal the number of genomes
            # used to create the homolog list
            if len(splitted) == len(genomes):
                # Check if there is no genome duplicate (indicates paralogs):
                all_genomes = []  # list initialization
                # For each members (each look like 'genome_code'|'gene_number'):
                # split them to keep only the genome code, and store each in a list
                for each_gene in splitted:
                    all_genomes.append(each_gene.split('|')[0])
                # Now check if the each genome code appears only once
                # by comparing list of unique (set()) elements number
                # against the number of genomes used to create the homolog list
                if len(set(all_genomes)) == len(genomes):
                    # If does, write the whole line (=family) in the output file
                    outfile.write(line)

filter(oldfile = oldfile, newfile = newfile, genomes = genomes)
