# Comparison-CE2
Time comparison for the execution of the 5 solutions in the different programming languages.

docker build -t benchmark_runner .

docker run --privileged --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/output:/output benchmark_runner
