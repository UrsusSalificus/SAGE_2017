# Will remove all the gene names in the indexes of the genomes in the trees

# Path to the directory containing the concatanated gene trees in Newick format:
gene_trees = '../files/phylogenetic_trees/aa_ML_noboot_gene_trees/concat_all_gene_trees'
# Path/name of the wanted output file
simplified_gene_trees = '../files/phylogenetic_trees/aa_ML_noboot_gene_trees//cleaned_concat_all_gene_trees'


def remove_genes_in_indexes(gene_trees, simplified_gene_trees):
    with open(gene_trees, 'r') as all_gene_trees, open(simplified_gene_trees, 'w') as outfile:
        for each_tree in all_gene_trees:
            splitted = each_tree.split('|')
            for each in splitted:
                if each.startswith("("):
                    outfile.write(each)
                else:
                    begin = each.find(':')
                    outfile.write(each[begin:])

remove_genes_in_indexes(gene_trees = gene_trees, simplified_gene_trees = simplified_gene_trees)



