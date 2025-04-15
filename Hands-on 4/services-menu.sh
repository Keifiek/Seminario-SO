#!/bin/bash
while true; do
	echo "Menu de Servicios"
	echo "1. Listar contenido de una carpeta"
	echo "2. Crear archivo con una linea de texto"
	echo "3. Comparar dos archivos"
	echo "4. Buscar usando awk"
	echo "5. Busccar usando grep"
	echo "6. Salir"
	read -p "Seleccione una opcion: " opcion
	case $opcion in 
		1)
			read -p "Ingrese la ruta absoluta de la carpeta: " ruta
			if [ -d "$ruta" ]; then 
				echo "Contenido de $ruta: "
				ls $ruta
			else 
				echo "Ruta no encontrada"
			fi
			;;
		2)
			read -p "Ingrese el nombre del archivo:" archivo
			read -p "Ingrese el texto que se guardara" texto
			echo "$texto" > "$archivo"
			echo "Archivo $archivo creado con exito"
			;;
		3)
			read -p "Ingrese la ruta del primer archivo: " archivo1
			read -p "Ingrese la ruta del segundo archivo: " archivo2
			if [ -f "$archivo1" ] && [ -f "$archivo2" ]; then
				echo "Comparando archivos"
				diff "$archivo1" "$archivo2"
			else 
				echo "Algun archivo no existe"
			fi
			;;
		4)
			read -p "Ingrese el archivo para usar awk: " archivoawk
			if [ -f "$archivoawk" ]; then
				echo "Mostrando la primer columna del archivo con awk"
				awk '{print $1}' "$archivoawk"
			else 
				echo "El archivo no existe"
			fi
			;;
		5)
			read -p "Ingrese el archivo para usar grep: " archivogrep
			read -p "Ingrese el texto a buscar: "  busqueda
			if [ -f "$archivogrep" ]; then
				echo "Resultados encontrados: "
				grep "$busqueda" "$archivogrep"
			else 
				echo "El archivo no existe"
			fi
			;;
		6)
			echo "Saliendo del menu..."
			break
			;;
		*)
			echo "Opcion Invalida"
			;;
	esac
done
