Instrucciones 

#Conectarse al servidor de Biotecnología Vegetal
ssh biologiacomparativa@190.145.98.43 -p 2225 

#Ejemplo para transferir archivos desde y hacia el servidor
scp -P 2225  .\16S\* biologiacomparativa@190.145.98.43:/home/biologiacomparativa/  

#Dirección de los archivos en el servidor
/home/biologiacomparativa/metagenomica_juli

#folder 16S o ITS contiene:
	#folder RV/ con los datos reverse descargados de BGI
	#folder FW/ con los datos forward descargados de BGI

#ejemplp para correr los programas en segundo plano
nohup R CMD BATCH ChimerasTaxonomy.R & 


#Se usaron 4 scripts
filtering_PE.R
cambiarnombres.sh  
infer_variants_PE.R 
ChimerasTaxonomy.R   

#Primer script: filtering_PE.R
#Entrada: Datos de los folder RV/ y FW/
#salidas: filtering_PE.Rout y folders RV/filtered y FW/filtered que contienen los datos filtrados

#Segundo script: cambiarnombres.sh 
#Se cambiaron los nombres de los archivos filtrados por nombres que contuvieran la nomenclatura de la muestra a la que pertenecen samplename_XXXX.fq.gz

#Tercer script: infer_variants_PE.
#Entrada: Datos renombrados de los folders RV/filtered y FW/filtered
#Salidas:
#infer_variants_PE.Rout: contiene el resumen de la ejecución del programa 
#infer_variants_PE_derep.RData : guarda los resultados intermedios de la corrida, las secuencias únicas por si ocurre algun error mas adelante.
#infer_variants_PE_learnErrors.RData: guarda los resultados intermedios de la corrida, aprendizaje de la tasa de error por si ocurre algun error mas adelante
#Archivo seqtab.rds

#Cuarto script: ChimerasTaxonomy.Rout 
#Entrada:Archivo seqtab.rds y Base de datos para asignación taxonómica (SILVA para bacterias o UNITE para hongos)
#Salidas: ChimerasTaxonomy.Rout , seqtab_final.rds y tax_final.rds


#scp -P 2225  biologiacomparativa@190.145.98.43:/home/biologiacomparativa/metagenomica_juli/16S/run1/seqtab_final.rds .


 
