# Usar docker:dind como base
FROM docker:dind

# Instalar Git y otros utilitarios necesarios
RUN apk add --no-cache git bash

# Clonar el repositorio
RUN git clone https://github.com/MRsnipero1324/Solutions-CE2.git /app

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el script de automatización
COPY benchmark.sh /app/benchmark.sh

# Dar permisos de ejecución al script
RUN chmod +x /app/benchmark.sh

# Ejecutar el script al iniciar el contenedor
CMD ["/app/benchmark.sh"]
