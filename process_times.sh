#!/bin/bash

# Directorio donde están los archivos
OUTPUT_DIR="./output"

# Verificar si la carpeta output existe
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "Error: La carpeta 'output' no existe."
    exit 1
fi

# Recorrer todos los archivos con el formato execution_time_*
for file in "$OUTPUT_DIR"/execution_time_*; do
    # Verificar si hay archivos que coincidan con el patrón
    [ -e "$file" ] || { echo "No se encontraron archivos en output."; exit 1; }

    # Extraer el nombre del lenguaje desde el nombre del archivo
    lang=$(basename "$file" | cut -d'_' -f3)

    # Extraer el tiempo de ejecución usando grep y awk
    time_ms=$(grep -o '[0-9]\+' "$file")

    # Mostrar el resultado en el formato requerido
    echo "$lang: $time_ms ms"
done
