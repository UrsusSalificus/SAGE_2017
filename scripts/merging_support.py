# Will merge all the supports of internal nodes of both bootstrap and single gene trees
import sys

# Path to the bootstrap supported tree
boot_tree = sys.argv[1]
# Path to the single gene supported tree
gene_tree = sys.argv[2]
# Path to the merged support tree
merged_tree = sys.argv[3]


def merging_support(boot_tree, gene_tree, merged_tree):
    with open(boot_tree, 'r') as b_tree, open(gene_tree, 'r') as g_tree, open(merged_tree, 'w') as m_tree:
        b_tree = b_tree.readline()
        g_tree = g_tree.readline()
        # Split by internal nodes
        b_split = b_tree.split(')')
        g_split = g_tree.split(')')
        # Don't take into account the first and last element of split list (first node, and \n at the end)
        all_support = [] * (len(b_split) - 2)
        # First, extract the bootstrap support
        for each in b_split:
            if not each.startswith("(") | each.startswith(";"):
                all_support.append(each.split(':')[0])
        # First, extract the bootstrap support
        i = 0
        for each in g_split:
            if not each.startswith("(") | each.startswith(";"):
                all_support[i] += '/' + each.split(':')[0]
                i += 1
        # Then extract the gene support, merge the two, and rewrite the newick tree
        k = 0
        for each in b_split:
            # First line, missing only a ) (split before) at the end
            if each.startswith("("):
                m_tree.write(each + ')')
            # Last line, just a newline...
            elif each.startswith(";"):
                m_tree.write(each)
            # All the lines in between: miss the : split before, and a ) split before also
            else:
                m_tree.write(all_support[k] + ':' + ':'.join(each.split(':')[1:]) + ')')
                k += 1

merging_support(boot_tree, gene_tree, merged_tree)

