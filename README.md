## SAGE course 2017: Core phylogeny
Sequence A GEnome (SAGE) course  is taking place at Lausanne University (Swiss) and involves sequencing and analyzing 
a bacterial genome.
This year course focuses on the bumble and honey bees gut-microbiota, more precisely on Firm-5 strain.
This [repository](https://github.com/UrsusSalificus/SAGE_2017) contains all the scripts used to perform the core 
phylogeny on different strains.  

#### WARNING
This analysis was developed to be computed on [Vital-IT](http://www.vital-it.ch/) clusters 
(which works through LSF jobs), due to the heavy computational load of maximum likelihood computation of phylogenetic 
trees.
The whole analysis scripts depicted below are thus based on serial `bsub`, and will not work properly on a personal 
computer.  
Take also into account that we may require the max number of cores available for normal queues (64) in a single host.  
This implies that the analysis may be stuck on `pending` on busy hours, when the cluster is heavily used.

#### The analysis
##### Computing the analysis
You will find on the main directory 4 bash scripts, performing 3 different analysis: `all_genomes` complete dataset 
(obsolete), `woutgroup` without outgroups and `bees` focusing on *Lactobacilli* in bumble bees only.  
These scripts will perform the whole computations from scratch, resulting in a "most likely" tree, supported by both 
bootstraps and single gene trees. 

##### Information on the analysis
In this project, we compute the maximum likelihood of phylogenetic trees using RAxML. The result is a phylogenetic tree
in Newick format, supported by both amount of bootstraps and single gene trees similar to a reference tree.
The reference tree is obtained through comparing 20 ML trees - on distinct starting trees - and keeping the tree with 
the best likelihood.  
To reduce as much as possible the computational time, we based our settings of RAxML and LSF jobs on Pfeiffer and 
Stamatakis's [article](http://www.phylo.org/sub_sections/portal/portal_papers/Exelixis-RRDR-2010-3.pdf)
and its [summary](https://wiki.rc.ufl.edu/doc/RAxML) from University of Florida Research Computing, and on
RAxML [manual](https://sco.h-its.org/exelixis/resource/download/NewManual.pdf) and 
[tutorial](https://sco.h-its.org/exelixis/web/software/raxml/hands_on.html).


#### Files and folder found in this repo
The main directory contains the 6 `bash` scripts mentioned earlier, and 3 subdirectories:


* `data` : contain all the necessary data to perform the analyses.
* `files` : contain all the output of the analyses.
* `scripts` : contain all the scripts needed to perform the analyses.



### Dependencies
Python 3 modules used during the analyses (all present on Vital-IT):
```
Bio (Biopython)
glob
joblib
re
subprocess
sys
```

Software used during the analyses (all present on Vital-IT):
```
MAFFT v.7.305
RAxML v.8.2.9
```
