**Analisis de datos de diversidad en suelos usando marcadores 16S e ITS**

A cotinuación se describe el proceso bioinformático para llevar a cabo los analisis de los datos.

**Tutoriales:**
Los tutoriales seguidos para este analisis son los siguientes:
https://benjjneb.github.io/dada2/bigdata_paired.html
https://vaulot.github.io/tutorials/Phyloseq_tutorial.html

**Datos:**

Crear una carpeta para cada tipo de datos ie: ITS, 16S

En cada una de las carpetas crea dos subcarpetas para los reads forward y reverse (FW, RV)

**Programas:** 

Para llevar a cabo el análisis es necesario tener instalados los paquetes DADA2 y Phyloseq de R
Tambien se debe disponer de los scripts aqui disponibles:
filtering_PE.R
cambiarnombres.sh  
infer_variants_PE.R 
ChimerasTaxonomy.R 
El script se debe modificar para poner las rutas de los archivos de entrada según sea el caso. Aquí estan disponibles con las rutas del servidor que usé pero cada persona debe rectificar la ubicación de sus datos de entrada y salidas


Para correr los programas en segundo plano en el servidor y poder disponer de la consola mientras el proceso termina se usa una linea de comando como la siguiente

nohup R CMD BATCH [ChimerasTaxonomy.R] & 

El nombre del script en parentesis se reemplaza segun la necesidad

**Pasos del análisis en DADA"**

![proceso](DADA2_proceso.png)

*Paso1:* Filtrado de los datos por calidad

Para este paso se utiliza el script "filtering_PE.R", al correr este script se generan los archivos con los datos limpios para 
proseguir el análisis. 

Primer script: filtering_PE.R
Entradas: Datos de los folder RV/ y FW/
salidas: filtering_PE.Rout y folders RV/filtered y FW/filtered que contienen los datos filtrados

*Paso2:* Se cambiaron los nombres de los archivos filtrados por nombres que contuvieran la nomenclatura de la muestra a la que pertenecen samplename_XXXX.fq.gz
Segundo script: cambiarnombres.sh 

*Paso3:* En este paso se comparan las secuencias para hallar variantes de nucleotido simple
Tercer script: infer_variants_PE.
Entrada: Datos renombrados de los folders RV/filtered y FW/filtered
Salidas:
infer_variants_PE.Rout: contiene el resumen de la ejecución del programa 
infer_variants_PE_derep.RData : guarda los resultados intermedios de la corrida, las secuencias únicas por si ocurre algun error mas adelante.
infer_variants_PE_learnErrors.RData: guarda los resultados intermedios de la corrida, aprendizaje de la tasa de error por si ocurre algun error mas adelante
Archivo seqtab.rds

*Paso 4:* En este paso se eliminan las quimeras y se hace la asignación taxonomica de los grupos usando basos de datos de referencia para cada marcador
Cuarto script: ChimerasTaxonomy.Rout 
Entrada:Archivo seqtab.rds y Base de datos para asignación taxonómica (SILVA para bacterias o UNITE para hongos)
Salidas: ChimerasTaxonomy.Rout , seqtab_final.rds y tax_final.rds



 