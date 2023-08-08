# Use the official certbot image as the base image
FROM certbot/certbot:v2.6.0

# Update package repositories, install required packages, and remove package cache
RUN apk update \
    && apk upgrade \
    && apk add --no-cache jq supervisor \
    && rm -rf /var/cache/apk/*    

ENV RENEW_CERTS_PERIODICITY=daily
COPY scripts/renew_certs /etc/periodic/${RENEW_CERTS_PERIODICITY}/renew_certs
RUN chmod +x /etc/periodic/${RENEW_CERTS_PERIODICITY}/renew_certs

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

CMD ["supervisord", "-n", "-c", "/configs/supervisord.conf"]
