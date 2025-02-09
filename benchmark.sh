#!/bin/bash

set -e

# Declarar los lenguajes y los Dockerfiles correspondientes
declare -a languages=("Python" "Cpp" "JavaScript" "Go" "Rust")
declare -a dockerfiles=("Dockerfile.Python" "Dockerfile.cpp" "Dockerfile.javascript" "Dockerfile.go" "Dockerfile.rust")

# Ejecutar los contenedores y generar los archivos execution_time_----
for i in "${!languages[@]}"; do
    lang="${languages[$i]}"
    dockerfile="${dockerfiles[$i]}"
    tag="matrix_${lang,,}"

    echo "Building and running container for $lang..."
    docker build -t $tag -f DockerFiles/$dockerfile .
    docker run --rm -v "$(pwd):$(pwd)" -w "$(pwd)" $tag || echo "Failed to run container for $lang"
done

# Crear el archivo benchmark.txt
echo "Creating benchmark.txt..."
if ls execution_time_* 1> /dev/null 2>&1; then
    # Extraer tiempos de ejecución y asociarlos con los lenguajes
    declare -A execution_times
    for lang in python js go rust cpp; do
        file="execution_time_${lang}.txt"
        if [[ -f $file ]]; then
            time=$(grep -oP "\d+(?= ms)" "$file")
            execution_times["$lang"]="$time"
        else
            echo "Warning: File $file not found."
        fi
    done

    # Ordenar los tiempos y generar el archivo benchmark.txt
    for lang in "${!execution_times[@]}"; do
        echo "$lang: ${execution_times[$lang]} ms"
    done | sort -k2 -n > benchmark.txt

    echo "Benchmark results saved in benchmark.txt."
else
    echo "No execution_time_* files found. Ensure containers are generating these files."
fi
