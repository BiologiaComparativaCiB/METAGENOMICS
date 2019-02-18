#!/bin/ksh
#ls *.fas > lista_archivos
# buscar .fas en lista_archivos, reemplazar con nada >"lista_archivos_names"
file="lista_archivos_name"
#for i in `seq 1 36`;do
#echo $i
i=0
while IFS= read line
do
	seqmagick "#convert $line.fas $line.nex"
done <"$file"
  
