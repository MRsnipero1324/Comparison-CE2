# Comparison-CE2

This repository allows you to compare the execution time of five different solutions implemented in various programming languages. The process involves building and running Docker containers for each language and then processing the execution times.

## Group members
Aaron Cabrales Contreras
Juan Pablo Guzman Restrepo

## How to Use

### Clone the repository

use the following to clone the repository
```bash
git clone https://github.com/MRsnipero1324/Comparison-CE2.git
```

and position the CLI in the folder

```bash
cd Comparison-CE2
```
### **Run the Containers**
This script builds and runs all necessary Docker containers, executing the solutions in different languages.

```bash
chmod +x run_containers.sh
./run_containers.sh
```

This script process the output of each container and shows an ordered table of the execution times.
```bash
chmod +x process_times.sh
./process_times.sh
```

## Benchmark code 
https://github.com/MRsnipero1324/Solutions-CE2.git