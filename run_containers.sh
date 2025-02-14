#!/bin/bash

# Verificar si Docker está corriendo
docker info > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Docker no está funcionando dentro del contenedor."
  exit 1
fi

echo "Construyendo y ejecutando contenedores..."

# Construir y ejecutar el primer contenedor
docker build -t contenedor_1 -f DockerFiles/Dockerfile.python .
docker run --rm -v /output:/output contenedor_1

# Construir y ejecutar el segundo contenedor
docker build -t contenedor_2 -f DockerFiles/Dockerfile.cpp .
docker run --rm -v /output:/output contenedor_2

echo "Ejecución completada."
ls -l /output  # Verificar los archivos generados
