# Base image
FROM docker:dind

# Install required dependencies
RUN apk add --no-cache \
    git \
    && rm -rf /var/cache/apk/*

# Set work directory
WORKDIR /app/Solutions-CE2

# Clone the repository
RUN git clone https://github.com/MRsnipero1324/Solutions-CE2.git /app/Solutions-CE2

# Add entrypoint script to execute all the commands
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Volumes for data sharing between host and container
VOLUME ["/app/Solutions-CE2"]

# Set the default command to execute the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]