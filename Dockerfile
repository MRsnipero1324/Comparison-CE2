# Usa Docker dentro de Docker (DinD)
FROM docker:dind

# Instalar herramientas necesarias
RUN apk add --no-cache git bash

# Clonar el repositorio con los contenedores
RUN git clone https://github.com/MRsnipero1324/Solutions-CE2.git /app

# Establecer directorio de trabajo
WORKDIR /app

# Copiar el script de ejecución
COPY run_containers.sh ./run_containers.sh

# Dar permisos de ejecución al script
RUN chmod +x ./run_containers.sh

# Ejecutar el script al iniciar
CMD ["./run_containers.sh"]

