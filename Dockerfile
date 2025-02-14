# Usa Docker-in-Docker como base
FROM docker:dind

# Instala git y cualquier otro paquete necesario
RUN apk add --no-cache git 

# Clona el repositorio dentro del contenedor
RUN git clone https://github.com/MRsnipero1324/Solutions-CE2.git /Solutions-CE2

# Define el directorio de trabajo
WORKDIR /Solutions-CE2

# Ejecutar el contenedor en modo DinD
CMD ["dockerd-entrypoint.sh"]
