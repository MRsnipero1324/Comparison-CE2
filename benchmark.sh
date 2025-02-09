#!/bin/bash

set -e

# Construir y ejecutar los contenedores
declare -a languages=("Python" "Java" "C++" "JavaScript" "Go" "Rust")
declare -a dockerfiles=("Dockerfile.Python" "Dockerfile.Java" "Dockerfile.cpp" "Dockerfile.javascript" "Dockerfile.go" "Dockerfile.rust")
output_dir="/output"

mkdir -p $output_dir

for i in "${!languages[@]}"; do
    lang="${languages[$i]}"
    dockerfile="${dockerfiles[$i]}"
    tag="matrix_${lang,,}"

    echo "Building and running container for $lang..."
    docker build -t $tag -f DockerFiles/$dockerfile .
    docker run --rm -v "$(pwd):$output_dir" $tag
done

# Crear el archivo benchmark.txt
echo "Creating benchmark.txt..."
ls $output_dir/execution_time_* | while read file; do
    lang_time=$(cat "$file" | grep -oP "\d+(?= ms)")
    echo "$(basename $file): $lang_time ms" >> $output_dir/benchmark_raw.txt
done

sort -n -k2 -t: $output_dir/benchmark_raw.txt | awk -F": " '{print $2 ": " $3}' > $output_dir/benchmark.txt
rm $output_dir/benchmark_raw.txt

# Mostrar resultados
echo "Benchmark results saved in benchmark.txt."
