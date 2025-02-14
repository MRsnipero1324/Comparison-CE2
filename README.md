# Comparison-CE2
Time comparison for the execution of the 5 solutions in the different programming languages.

apk add nano git
git clone https://github.com/MRsnipero1324/Comparison-CE2.git
cd Comparison-CE2
docker build -t benchmark_runner .
docker run --privileged --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/output:/output benchmark_runner

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
