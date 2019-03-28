library(dada2); packageVersion("dada2")
# File parsing
pathF <- "/home/biologiacomparativa/metagenomica_juli/16S/FW" # CHANGE ME to the directory containing your demultiplexed forward-read fastqs
pathR <- "/home/biologiacomparativa/metagenomica_juli/16S/RV" # CHANGE ME ...
filtpathF <- file.path(pathF, "filtered") # Filtered forward files go into the pathF/filtered/ subdirectory
filtpathR <- file.path(pathR, "filtered") # ...
fastqFs <- sort(list.files(pathF, pattern="_1.fq"))
fastqRs <- sort(list.files(pathR, pattern="_2.fq"))
if(length(fastqFs) != length(fastqRs)) stop("Forward and reverse files do not match.")
# Filtering: THESE PARAMETERS ARENT OPTIMAL FOR ALL DATASETS
filterAndTrim(fwd=file.path(pathF, fastqFs), filt=file.path(filtpathF, fastqFs),
              rev=file.path(pathR, fastqRs), filt.rev=file.path(filtpathR, fastqRs),
              truncLen=c(240,200), maxEE=2, truncQ=11, maxN=0, rm.phix=TRUE,
              compress=TRUE, verbose=TRUE, multithread=TRUE)


