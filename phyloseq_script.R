#Three tables are needed
#OTU
#Taxonomy
#Samples
 
#Load necessary libraries
library("phyloseq")
library("ggplot2")
library("readxl")
library("dplyr")

#Read Tables form xlsx files

otu_mat<- read_excel("/home/baya/juliana/BGI_DATA_FONTAGRO/mejorados_clean/dada2/ITS/OTU_mat.xlsx", sheet = "seqtab_t")

tax_mat<- read_excel("/home/baya/juliana/BGI_DATA_FONTAGRO/mejorados_clean/dada2/ITS/taxa_mat.xlsx", sheet = "taxa_mat")

samples_df <- read_excel("/home/baya/juliana/BGI_DATA_FONTAGRO/mejorados_clean/dada2/ITS/metadata_ITS.xlsx", sheet = "Sheet3")

#Define the row names from the otu column
row.names(otu_mat) <- otu_mat$OTU

#remove the column otu since it is now used as a row name
otu_mat <- otu_mat %>% select (-OTU)

#Idem for the two other matrixes
row.names(tax_mat) <- tax_mat$OTU
tax_mat <- tax_mat %>% select (-OTU) 

row.names(samples_df) <- samples_df$nombre_muestra
samples_df <- samples_df %>% select (-nombre_muestra) 


#Transform into matrixes otu and tax tables (sample table can be left as data frame)
otu_mat <- as.matrix(otu_mat)
tax_mat <- as.matrix(tax_mat)

#Transform to phyloseq objects
OTU = otu_table(otu_mat, taxa_are_rows = TRUE)
TAX = tax_table(tax_mat)
samples = sample_data(samples_df)
  
carbom <- phyloseq(OTU, TAX, samples)
carbom

#Normalize number of reads in each sample using median sequencing depth.

total = median(sample_sums(carbom))
standf = function(x, t=total) round(t * (x / sum(x)))
carbom = transform_sample_counts(carbom, standf)

#The number of reads used for normalization is 44903.

#Basic bar graph based on Phylum
 plot_bar(carbom, fill = "Phylum")


#Regroup together Textura_suelo

  carbom_texture <- merge_samples(carbom, "textura_suelo")
  plot_bar(carbom_texture, fill = "Phylum") + 
  geom_bar(aes(color=Phylum, fill=Phylum), stat="identity", position="stack")

#Regroup together PH
  carbom_pH<- merge_samples(carbom, "pH")
  plot_bar(carbom_pH, fill = "Phylum") + 
  geom_bar(aes(color=Phylum, fill=Phylum), stat="identity", position="stack")

#A basic heatmap using the default parameters.
plot_heatmap(carbom, method = "NMDS", distance = "bray")

#It is very very cluttered. It is better to only consider the most abundant OTUs for heatmaps. For example one can only take OTUs that represent at least 20% of reads in at least one sample. Remember we normalized all the sampples to median number of reads (total). We are left with only 33 OTUS which makes the reading much more easy.

carbom_abund <- filter_taxa(carbom, function(x) sum(x > total*0.20) > 0, TRUE)
carbom_abund
otu_table(carbom_abund)

#Seleccionar Capnodiales y abundancia de los generos
carbom_capnodiales <- subset_taxa(carbom, Order %in% c("o__Capnodiales"))
  plot_bar(carbom_capnodiales, x="Genus", fill = "Genus") +
  geom_bar(aes(color=Genus, fill=Genus), stat="identity", position="stack")

#Heatmap de los Genus en Capnodiales

plot_heatmap(carbom_capnodiales, method = "NMDS", distance = "bray", 
               taxa.label = "Genus", taxa.order = "Genus", 
               low="beige", high="red", na.value="beige")


#Alpha diversity

#Plot Chao1 richness estimator and Shannon diversity estimator.
plot_richness(carbom, measures=c("Chao1", "Shannon"))
#Warning message:
#Removed 8 rows containing missing values (geom_errorbar).

#Ordination
#Do multivariate analysis based on Bray-Curtis distance and NMDS ordination.
carbom.ord <- ordinate(carbom, "NMDS", "bray")



#Plot OTUs
plot_ordination(carbom, carbom.ord, type="taxa", color="Class", shape= "Phylum", 
                  title="OTUs")

#A bit confusing, so make it more easy to visualize by breaking according to taxonomic division.

plot_ordination(carbom, carbom.ord, type="taxa", color="Class", title="OTUs", label="Class") facet_wrap(~Phylum, 3)



plot_ordination(carbom, carbom.ord, type="taxa", color="Phylum", title="OTUs", label="Pylum")+ facet_wrap(~Phylum, 3)

#Simple network analysis

  plot_net(carbom, distance = "(A+B-2*J)/(A+B)", type = "taxa", 
           maxdist = 0.7, color="Class", point_label="Family")


carbom_abund <- filter_taxa(carbom, function(x) sum(x > total*0.02) > 0, TRUE)
carbom_abund
#> carbom_abund
#phyloseq-class experiment-level object
#otu_table()   OTU Table:         [ 56 taxa and 8 samples ]
#sample_data() Sample Data:       [ 8 samples by 7 sample variables ]
#tax_table()   Taxonomy Table:    [ 56 taxa by 7 taxonomic ranks ]



#using only majorOTUS
plot_net(carbom_abund, distance = "(A+B-2*J)/(A+B)", type = "taxa", 
           maxdist = 0.8, color="Class", point_label="Genus") 
