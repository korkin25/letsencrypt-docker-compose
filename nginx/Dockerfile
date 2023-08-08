# Use the official Nginx image as the base image
FROM nginx:1.25.1-alpine

# Update package repositories, install required packages, and remove package cache
RUN apk update \
    && apk upgrade \
    && apk add --no-cache supervisor openssl jq \
    && rm -rf /var/cache/apk/*

ENV RENEW_CERTS_PERIODICITY=15min
COPY scripts/reload_certs /etc/periodic/${RENEW_CERTS_PERIODICITY}/reload_certs
RUN chmod +x /etc/periodic/${RENEW_CERTS_PERIODICITY}/reload_certs

# Set the working directory for the configuration files and copy them to the image
WORKDIR /configs
COPY configs/ ./

# Create the scripts directory and set it as the working directory
RUN mkdir /scripts
WORKDIR /scripts

# Copy all shell scripts to the scripts directory
COPY scripts/*.sh ./

# Make all shell scripts executable
RUN chmod +x *.sh

# Expose port 80 for the web server
EXPOSE 80

# Define the command to start the supervisor process using the configuration file
CMD ["supervisord", "-n", "-c", "/configs/supervisord.conf"]
