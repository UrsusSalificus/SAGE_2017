# Will remove all the gene names in the indexes of the genomes in the trees
import re
import sys

# Path to the directory containing the concatanated gene trees in Newick format:
gene_trees = sys.argv[1]
# Path/name of the wanted output file
simplified_gene_trees = sys.argv[2]
# Path to the directory containing the codes for the genomes:
codes_for_genomes = sys.argv[3]

###
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
            # Here, will take the third column (OrthoMCL_prefix column) as keys
            # And the second column (Strain_prefix) as value
            translation[splitted[2]] = splitted[1]
    return(translation)

def remove_genes_in_indexes(gene_trees, simplified_gene_trees, dico):
    with open(gene_trees, 'r') as all_gene_trees, open(simplified_gene_trees, 'w') as outfile:
        for each_tree in all_gene_trees:
            # First, will translate the genome names
            pattern = re.compile("|".join(dico.keys()))
            each_tree = pattern.sub(lambda m: dico[re.escape(m.group(0))], each_tree)
            # Then, will take out the gene names
            splitted = each_tree.split('|')
            for each in splitted:
                if each.startswith("("):
                    outfile.write(each)
                else:
                    begin = each.find(':')
                    outfile.write(each[begin:])

dico = extract_translation(codes_for_genomes = codes_for_genomes)
remove_genes_in_indexes(gene_trees = gene_trees, simplified_gene_trees = simplified_gene_trees, dico = dico)


