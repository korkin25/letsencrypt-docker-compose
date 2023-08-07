# Use the official Nginx image as the base image
FROM nginx:1.25.1-alpine

# Update package repositories, install required packages, and remove package cache
RUN apk update \
    && apk upgrade \
    && apk add --no-cache supervisor openssl jq certbot \
    && rm -rf /var/cache/apk/*

ENV RENEW_CERTS_PERIODICITY=daily
COPY scripts/renew_certs /etc/periodic/${RENEW_CERTS_PERIODICITY}/renew_certs
RUN chmod +x /etc/periodic/${RENEW_CERTS_PERIODICITY}/renew_certs

# Set the working directory for the configuration files and copy them to the image
WORKDIR /configs
COPY configs/* ./

# Set the working directory for the scripts and copy them to the image
WORKDIR /scripts
COPY scripts/*.sh ./
RUN chmod +x *.sh

# Expose port 80 for the web server
EXPOSE 80

# Define the command to start the supervisor process using the configuration file
CMD ["supervisord", "-n", "-c", "/etc/supervisord.conf"]
