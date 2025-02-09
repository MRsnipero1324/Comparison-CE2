#!/bin/bash

# Navegar al directorio de trabajo
cd /app/Solutions-CE2

# Construir y ejecutar los contenedores para cada lenguaje
docker build -t matrix_python -f DockerFiles/Dockerfile.python .
docker run --rm -v $(pwd):/app/Solutions-CE2 matrix_python

docker build -t matrix_java -f DockerFiles/Dockerfile.java .
docker run --rm -v $(pwd):/app/Solutions-CE2 matrix_java

docker build -t matrix_cpp -f DockerFiles/Dockerfile.cpp .
docker run --rm -v $(pwd):/app/Solutions-CE2 matrix_cpp

docker build -t matrix_js -f DockerFiles/Dockerfile.javascript .
docker run --rm -v $(pwd):/app/Solutions-CE2 matrix_js

docker build -t matrix_go -f DockerFiles/Dockerfile.go .
docker run --rm -v $(pwd):/app/Solutions-CE2 matrix_go

docker build -t matrix_rust -f DockerFiles/Dockerfile.rust .
docker run --rm -v $(pwd):/app/Solutions-CE2 matrix_rust
