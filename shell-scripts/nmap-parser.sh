#!/bin/bash

# Este programa parsea los resultados de nmap y construye un documento html

TITLE="Resultados nmap"
FECHA_ACTUAL="$(date)"
TIMESTAMP="Informe generado el $FECHA_ACTUAL por el usuario $USERNAME"

nmap_report () {
	# Generamos el reporte  raw con nmap
	echo "[INFO] Ejecutando nmap, por favor espere unos segundos..."
	sudo nmap -sV "$1" > "$2"
	echo "[OK] Fichero $2 generado correctamente"
	# Dividimos el fichero por lineas vacias
	echo "[INFO] Dividiendo el fichero $2..."
	csplit "$2" '/^$/' {*} > /dev/null
	echo "[INFO] Fichero $2 dividido en los siguientes ficheros: $(ls xx*)"
	return 0
}

if [ $(find $2 -mmin -30) ]; then
      while true; do
	read -p "Existe $2 con antiguedad menor a 30 minutos. Sobreescribir? [y/n]: "
	case "$REPLY" in
	  y) nmap_report $1 $2
	     break
	     ;;
	  n) echo "[INFO] Utilizando el fichero $2 existente."
	     break
	     ;;
	esac
      done
else
	nmap_report $1 $2
fi

# Generamos el reporte con los resultados de nmap en HTML
echo "[INFO] Generando reporte html..."
. html-report.sh
generar_html > $3
echo "[OK] Reporte $3 generado correctamente."
