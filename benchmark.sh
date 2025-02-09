#!/bin/bash

docker build -t matrix_python -f DockerFiles/Dockerfile.Python . 
docker run --rm -v $(pwd)/output:/output matrix_python

docker build -t matrix_cpp -f DockerFiles/Dockerfile.cpp .
docker run --rm -v $(pwd)/output:/app/output matrix_cpp

docker build -t matrix_js -f DockerFiles/Dockerfile.javascript .
docker run --rm -v $(pwd)/output:/output matrix_js

docker build -t matrix_go -f DockerFiles/Dockerfile.go .
docker run --rm -v $(pwd)/output:/output matrix_go

docker build -t matrix_rust -f DockerFiles/Dockerfile.rust .
docker run --rm -v $(pwd)/output:/app/output matrix_rust
