#!/bin/bash

docker build -t custom-dind .

docker run --privileged -d --rm --name dind-container custom-dind

sleep 5


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

docker cp dind-container:/Solutions-CE2/output ./output

docker stop dind-container
