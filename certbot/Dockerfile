FROM certbot/certbot:v2.6.0

RUN apk update && \
    apk upgrade && \
    apk --no-cache add jq && \
    rm -rf /var/cache/apk/*

# Create the scripts directory and set it as the working directory
RUN mkdir /scripts
WORKDIR /scripts

# Copy all shell scripts to the scripts directory
COPY scripts/certbot-certonly.sh scripts/certbot-delete.sh scripts/certbot-force-renew.sh scripts/start-certbot.sh ./

# Make all shell scripts executable
RUN chmod +x *.sh

# Run the start-certbot.sh script as the container's command
CMD ["/scripts/start-certbot.sh"]
