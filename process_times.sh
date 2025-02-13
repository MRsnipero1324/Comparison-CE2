#!/bin/bash

OUTPUT_DIR="./output"

# Verificar si la carpeta output existe
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "Error: La carpeta 'output' no existe."
    exit 1
fi

# Verificar si hay archivos que coincidan con el patrón
if ! ls "$OUTPUT_DIR"/execution_time_* &>/dev/null; then
    echo "No se encontraron archivos en output."
    exit 1
fi

declare -a results

# Recorrer todos los archivos con el formato execution_time_*
for file in "$OUTPUT_DIR"/execution_time_*; do
    # Extraer el nombre del lenguaje desde el nombre del archivo (sin extensión)
    lang=$(basename "$file" | sed -E 's/execution_time_([^.]*)\..*/\1/')

    # Extraer el tiempo de ejecución incluyendo decimales
    time_ms=$(grep -oE '[0-9]+(\.[0-9]+)?' "$file")

    if [[ -z "$time_ms" ]]; then
        echo "Advertencia: No se encontró un tiempo válido en $file"
        continue
    fi

    results+=("$time_ms $lang")
done

printf "%s\n" "${results[@]}" | sort -n | awk '{print $2 ": " $1 " ms"}'
