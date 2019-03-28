library(dada2); packageVersion("dada2")
# Merge multiple runs (if necessary)
st1 <- readRDS("/home/biologiacomparativa/metagenomica_juli/16S/run1/seqtab.rds")
#st2 <- readRDS("path/to/run2/output/seqtab.rds")
#st3 <- readRDS("path/to/run3/output/seqtab.rds")
#st.all <- mergeSequenceTables(st1, st2, st3)
# Remove chimeras
seqtab <- removeBimeraDenovo(st1, method="consensus", multithread=TRUE)
# Assign taxonomy
tax <- assignTaxonomy(seqtab, "/home/biologiacomparativa/metagenomica_juli/DATABASES/16S/silva_nr_v132_train_set.fa.gz", multithread=TRUE)
save.image("ChimerasTaxonomy.RData")
# Write to disk
saveRDS(seqtab, file= "/home/biologiacomparativa/metagenomica_juli/16S/run1/seqtab_final.rds.gz") # CHANGE ME to where you want sequence table saved
saveRDS(tax, file= "/home/biologiacomparativa/metagenomica_juli/16S/run1/tax_final.rds.gz") # CHANGE ME ...

