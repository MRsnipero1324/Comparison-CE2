#!/bin/bash

set -e

# Declarar los lenguajes y los Dockerfiles correspondientes
declare -a languages=("Python" "C++" "JavaScript" "Go" "Rust")
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
    # Extraer tiempos de ejecución y ordenarlos
    ls execution_time_* | while read file; do
        lang_time=$(cat "$file" | grep -oP "\d+(?= ms)")
        echo "$(basename $file): $lang_time ms" >> benchmark_raw.txt
    done

    sort -n -k2 -t: benchmark_raw.txt | awk -F": " '{print $2 ": " $3}' > benchmark.txt
    rm benchmark_raw.txt
    echo "Benchmark results saved in benchmark.txt."
else
    echo "No execution_time_* files found. Ensure containers are generating these files."
fi
