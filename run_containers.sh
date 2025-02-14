#!/bin/bash

echo "Construyendo y ejecutando contenedores..."

docker build -t matrix_python -f DockerFiles/Dockerfile.Python . 
docker run --rm -v $(pwd)/output:/output matrix_python
ls -l /output  # Verificar los archivos generados

docker build -t matrix_cpp -f DockerFiles/Dockerfile.cpp .
docker run --rm -v $(pwd)/output:/app/output matrix_cpp
ls -l /output  # Verificar los archivos generados

echo "Ejecución completada."
ls -l /output  # Verificar los archivos generados
