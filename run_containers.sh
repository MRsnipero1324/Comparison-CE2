#!/bin/bash

# Verificar si Docker está corriendo
docker info > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Docker no está funcionando dentro del contenedor."
  exit 1
fi

echo "Construyendo y ejecutando contenedores..."

docker build -t matrix_python -f DockerFiles/Dockerfile.Python . 
docker run --rm -v $(pwd)/output:/output matrix_python

docker build -t matrix_cpp -f DockerFiles/Dockerfile.cpp .
docker run --rm -v $(pwd)/output:/app/output matrix_cpp

echo "Ejecución completada."
ls -l /output  # Verificar los archivos generados
