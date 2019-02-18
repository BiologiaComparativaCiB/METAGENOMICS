#!/bin/ksh
#ls *.fq.gz > lista_archivos
# buscar .fq.gz en lista_archivos, reemplazar con nada >"lista_archivos_names"
file="lista_archivos_names"
while IFS= read line
do
        
	#mostrar linea 
	echo "$line" >>grep.out.space
	#descomprimir los archivos de entrada
	gzip -d $line.fq.gz
	
	# mostrar patron y buscar patron en $line
	echo "FCHL72LBCX2:1:1110:3495" >>grep.out
	grep -c "FCHL72LBCX2:1:1110:3495 " $line.fq  >>grep.out
	grep -n "FCHL72LBCX2:1:1110:3495 " $line.fq  >>grep.out

	echo "FCHL72LBCX2:1:1101:14860" >>grep.out
	grep -c "FCHL72LBCX2:1:1101:14860 " $line.fq  >>grep.out
	grep -n "FCHL72LBCX2:1:1101:14860 " $line.fq  >>grep.out

	echo "FCHL72LBCX2:1:1101:16533" >>grep.out
	grep -c "FCHL72LBCX2:1:1101:16533" $line.fq  >>grep.out
	grep -n "FCHL72LBCX2:1:1101:16533" $line.fq  >>grep.out

	echo "FCHL72LBCX2:1:2107:7163" >>grep.out
	grep -c "FCHL72LBCX2:1:2107:7163 " $line.fq  >>grep.out
	grep -n "FCHL72LBCX2:1:2107:7163 " $line.fq  >>grep.out

	echo "FCHL72LBCX2:1:1208:2101" >>grep.out
	grep -c "FCHL72LBCX2:1:1208:2101 " $line.fq  >>grep.out
	grep -n "FCHL72LBCX2:1:1208:2101 " $line.fq  >>grep.out

	echo "FCHL72LBCX2:1:1113:8049" >>grep.out
	grep -c "FCHL72LBCX2:1:1113:8049 " $line.fq  >>grep.out
	grep -n "FCHL72LBCX2:1:1113:8049 " $line.fq  >>grep.out

	echo "FCHL72LBCX2:1:1108:12404" >>grep.out
	grep -c "FCHL72LBCX2:1:1108:12404 " $line.fq  >>grep.out
	grep -n "FCHL72LBCX2:1:1108:12404 " $line.fq  >>grep.out

	echo "FCHL72LBCX2:1:1101:5034" >>grep.out
	grep -c "FCHL72LBCX2:1:1101:5034 " $line.fq  >>grep.out
	grep -n "FCHL72LBCX2:1:1101:5034 " $line.fq  >>grep.out

	echo "FCHL72LBCX2:1:1101:7853" >>grep.out
	grep -c "FCHL72LBCX2:1:1101:7853 " $line.fq  >>grep.out
	grep -n "FCHL72LBCX2:1:1101:7853 " $line.fq  >>grep.out

	echo "FCHL72LBCX2:1:1108:17934" >>grep.out
	grep -c "FCHL72LBCX2:1:1108:17934 " $line.fq  >>grep.out
	grep -n "FCHL72LBCX2:1:1108:17934 " $line.fq  >>grep.out

	echo "FCHL72LBCX2:1:1108:17080" >>grep.out
	grep -c "FCHL72LBCX2:1:1108:17080 " $line.fq  >>grep.out
	grep -n "FCHL72LBCX2:1:1108:17080 " $line.fq  >>grep.out

	#borrar archivo de entrada
	rm -r $line.fq
	
done <"$file"

