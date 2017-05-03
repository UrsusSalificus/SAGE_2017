# To extract the sequence from a list of families of orthologs.

import subprocess

# Path to the directory containing the codes for the genomes:
codes_for_genomes = "../../genome_files/file_list"
# Path to the list of orthologs
list_of_orthologs = "../files/orthologs_only"
# Path to the .faa files
protein_sequences = "../../genome_files/"

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
# For each family of orthologs, fetch the sequences of each members (= each genes)
# Inputs:
#   - dico: Translation table.
#   - list_of_orthologs: Path to the list of orthologs
# Output:
#   - n files (where n = number of families) containg each l sequences (where l = number of members in the family)
###
def fetching_aa_sequence (dico, list_of_orthologs, protein_sequences):
    # List which will contain all the sequences for each family
    # Length : number of different genomes/strains
    #   - len(dico) - 1 -> because we have the first line = headers in dico
    list_each_family = [""] * (len(dico) - 1)

    with open(list_of_orthologs, 'r') as ortho_families:
        # Counting the number of family using i
        i = 1
        for each_family in ortho_families:
            splitted = each_family.split()
            # For each gene in the ortholog family
            # Encounter some problems with strings turned to list with += :
            #   - Will attribute and count by hand with k
            k = 0
            for each_member in splitted:
                genome_gene = each_member.split('|')
                first_line = ">" + each_member + "\n"
                # We encountered a problem : for 1 pattern -> sometime extract multiple sequence:
                # A) Okay, use exact matching!
                #   - For F5 type : Needs exact matching -> otherwise problems of multiple sequences.
                #       - Gene name is separated from the rest by .  = CAN use exact word searching
                #   - For others : Some need exact matching, other don't.
                #       - Indeed, some .faa have genes listed 0000x to xxxxx, while other have listed as x0000 to xxxxx
                #           - The second case NEEDS exact matching, the first don't.
                #       - Problem : gene name is linked to genome name by _  = CAN'T use exact word searching
                # B) Okay, treat the problematic ones apart : use what separates each sequence in those cases !
                #   - First treat all F5 as a block (need exact matching),
                #       - Then treat all the others (can't use exact matching).
                #   - Others :  need to separate each sequence -> all have newlines at the end.
                #       - BUT : some (Ldel (LDB) and Lhel (LHV)) have newlines inside the sequence (every 60 char).
                #           - Luckily Ldel (LDB) and Lhel (LHV) are 0000x to xxxxx type = NO problem of multiple seq.
                # C) Okay, treat first F5, then Ldel (LDB) and Lhel (LHV), then others by splitting by bnewlines.
                if dico[genome_gene[0]].find('F5_') == 0:
                    # When F5 type, use exact matching:
                    # We use a source code to extract the sequence using awk:
                    #   - We will use subprocess, which needs as input a list of all the
                    #       different parts of the source code.
                    #   - Awk:
                    #       - /'pattern1'/ {flag=1;next}  -> Initial pattern found:
                    #           -> turn on the flag and read the next line
                    #           - Note : for exact matching, use \<'pattern1'\>
                    #       - /'pattern2'/ {flag = 0}  -> Final pattern found:
                    #           -> turn off the flag
                    #       - flag {print}  -> print the flagged lines
                    command = ['awk',
                               str('/\<' + genome_gene[1] + '\>/ {flag=1;next} />/{flag=0} flag {print}'),
                               str(protein_sequences + dico[genome_gene[0]] + '.faa')
                               ]
                    # First want the output of the source command -> check_output()
                    # Secondly, we want to avoid to have the output as byte -> .decode(sys.stdout.encoding)
                    gene_sequence = subprocess.check_output(command).decode(sys.stdout.encoding)

                elif genome_gene[0].find('LDB') == 0 or genome_gene[0].find('LHV') == 0:
                    # LDB/LHV special case : 0000x to xxxxx = no problem
                    command = ['awk',
                               str('/' + genome_gene[1] + '/ {flag=1;next} />/{flag=0} flag {print}'),
                               str(protein_sequences + dico[genome_gene[0]] + '.faa')
                               ]
                    gene_sequence = subprocess.check_output(command).decode(sys.stdout.encoding)

                else:
                    # Some are x0000 to xxxxx -> may have problem of multiple seq -> use newlines to split.
                    command = ['awk',
                               str('/' + genome_gene[1] + '/ {flag=1;next} />/{flag=0} flag {print}'),
                               str(protein_sequences + dico[genome_gene[0]] + '.faa')
                               ]
                    gene_sequence = subprocess.check_output(command).decode(sys.stdout.encoding)
                    # First split by newline, then choose the first sequence.
                    # .replace('*', '') will make sure to take out the stop-codon (found in some .faa)
                    # + '\n' add a newline at the end of the sequence (as * is before \n we lose it)
                    gene_sequence = gene_sequence.split()[0].replace('*', '') + '\n'

                # Each element must be : identifier + sequence.
                whole_sequence = str(first_line) + str(gene_sequence)
                list_each_family[k] = whole_sequence
                # Update k -> at which member of the family we are
                k += 1
            newfile = "sequences_per_family_for_align/" + "family_" + str(i)
            # Now create a specific file for this family and write every sequence one after the other
            with open(newfile, 'w') as outfile:
                for each_sequence in list_each_family:
                    outfile.write(each_sequence)
            # Update i -> at which family we are
            i += 1

dico = extract_translation(codes_for_genomes = codes_for_genomes)
fetching_aa_sequence(dico = dico, list_of_orthologs = list_of_orthologs, protein_sequences = protein_sequences)
