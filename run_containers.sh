#!/bin/bash

# 1. Construir la imagen personalizada de DinD
docker build -t custom-dind .

# 2. Ejecutar el contenedor en modo privilegiado y en segundo plano
docker run --privileged -d --rm --name dind-container custom-dind

# 3. Esperar unos segundos para que Docker dentro del contenedor esté listo
sleep 5

# Crear el directorio de salida en el contenedor DinD
docker exec -it dind-container mkdir -p /Solutions-CE2/output

# 4. Ejecutar los comandos dentro del contenedor DinD
docker exec -it dind-container sh -c "
    cd /Solutions-CE2 && \

    # Construir imagen de Python
    docker build -t matrix_python -f DockerFiles/Dockerfile.Python . && \
    docker run --rm -v /Solutions-CE2/output:/output matrix_python && \

    # Construir imagen de C++
    docker build -t matrix_cpp -f DockerFiles/Dockerfile.cpp . && \
    docker run --rm -v /Solutions-CE2/output:/app/output matrix_cpp && \

    docker build -t matrix_js -f DockerFiles/Dockerfile.javascript . && \
    docker run --rm -v /Solutions-CE2/output:/output matrix_js && \

    docker build -t matrix_go -f DockerFiles/Dockerfile.go . && \
    docker run --rm -v /Solutions-CE2/output:/output matrix_go && \

    docker build -t matrix_rust -f DockerFiles/Dockerfile.rust . && \
    docker run --rm -v /Solutions-CE2/output:/app/output matrix_rust && \
"

# 5. Copiar la carpeta de salida desde el contenedor al host
docker cp dind-container:/Solutions-CE2/output ./output

# 6. Detener el contenedor DinD (opcional, ya que usamos --rm)
docker stop dind-container
