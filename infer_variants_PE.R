library(dada2); packageVersion("dada2")
# File parsing
filtpathF <- "/home/biologiacomparativa/metagenomica_juli/16S/FW/filtered_2" # CHANGE ME to the directory containing your filtered forward fastqs
filtpathR <- "/home/biologiacomparativa/metagenomica_juli/16S/RV/filtered_2" # CHANGE ME ...
filtFs <- list.files(filtpathF, pattern="_1.fq", full.names = TRUE)
filtRs <- list.files(filtpathR, pattern="_2.fq", full.names = TRUE)
sample.names <- sapply(strsplit(basename(filtFs), "_"), `[`, 1) # Assumes filename = samplename_XXX.fastq.gz
sample.namesR <- sapply(strsplit(basename(filtRs), "_"), `[`, 1) # Assumes filename = samplename_XXX.fastq.gz
if(!identical(sample.names, sample.namesR)) stop("Forward and reverse files do not match.")
names(filtFs) <- sample.names
names(filtRs) <- sample.names
set.seed(100)
# Learn forward error rates
errF <- learnErrors(filtFs, nbases=1e8, multithread=TRUE)
# Learn reverse error rates
errR <- learnErrors(filtRs, nbases=1e8, multithread=TRUE)
save.image(file="infer_variants_PE_learnErrors.RData")
# Sample inference and merger of paired-end reads
mergers <- vector("list", length(sample.names))
names(mergers) <- sample.names
for(sam in sample.names) {
  cat("Processing:", sam, "\n")
    derepF <- derepFastq(filtFs[[sam]])
    ddF <- dada(derepF, err=errF, multithread=TRUE)
    derepR <- derepFastq(filtRs[[sam]])
    ddR <- dada(derepR, err=errR, multithread=TRUE)
    merger <- mergePairs(ddF, derepF, ddR, derepR)
    mergers[[sam]] <- merger
}
rm(derepF); rm(derepR)
save.image(file = "infer_variants_PE_derep.RData")
# Construct sequence table and remove chimeras
seqtab <- makeSequenceTable(mergers)
saveRDS(seqtab, file = "/home/biologiacomparativa/metagenomica_juli/16S/run1/seqtab.rds.gz") # CHANGE ME to where you want sequence table saved
