#!/bin/ksh
#ls *.fq.gz > lista_archivos
# buscar .fq.gz en lista_archivos, reemplazar con nada >"lista_archivos_names"
file="lista_archivos"
while IFS= read line
do
	#mostrar linea 
	echo "$line" >>seqkit.out
	#descomprimir los archivos de entrada
	seqkit rmdup --by-name $line >$line.unicos
	#gzip -9 $line.unicos.fq
	#borrar archivo de entrada
	#rm -r $line.unicos.fq
	
done <"$file"

