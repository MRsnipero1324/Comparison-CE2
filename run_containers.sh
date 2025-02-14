#!/bin/bash

# 1. Ejecutar el contenedor DinD en modo privilegiado y en segundo plano
docker run --privileged -d --rm --name dind-container docker:dind

# 2. Esperar unos segundos para que Docker dentro del contenedor esté listo
sleep 5

# 3. Ejecutar los comandos dentro del contenedor DinD
docker exec -it dind-container sh -c "
    apk add --no-cache git && \
    git clone https://github.com/MRsnipero1324/Solutions-CE2.git && \
    cd Solutions-CE2 && \
    
    # Construir imagen de Python
    docker build -t matrix_python -f DockerFiles/Dockerfile.Python . && \
    docker run --rm -v \$(pwd)/output:/output matrix_python && \

    # Construir imagen de C++
    docker build -t matrix_cpp -f DockerFiles/Dockerfile.cpp . && \
    docker run --rm -v \$(pwd)/output:/app/output matrix_cpp && \

    docker build -t matrix_js -f DockerFiles/Dockerfile.javascript . && \
    docker run --rm -v \$(pwd)/output:/output matrix_js && \

    docker build -t matrix_go -f DockerFiles/Dockerfile.go . && \
    docker run --rm -v \$(pwd)/output:/output matrix_go && \

    docker build -t matrix_rust -f DockerFiles/Dockerfile.rust . && \
    docker run --rm -v \$(pwd)/output:/app/output matrix_rust 
"

# 4. Copiar la carpeta de salida desde el contenedor al host
docker cp dind-container:/Solutions-CE2/output ./output

# 5. Detener el contenedor DinD (opcional, porque usamos --rm)
docker stop dind-container
