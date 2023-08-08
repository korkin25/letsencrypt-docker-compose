FROM certbot/certbot:v2.6.0

RUN apk update \
    && apk upgrade \
    && apk --no-cache add jq \
    && rm -rf /var/cache/apk/*

WORKDIR /scripts

# Copy all shell scripts to the current directory
COPY scripts/*.sh ./

# Make all shell scripts executable
RUN chmod +x *.sh

# Run the start-certbot.sh script as the container's command
CMD ["/scripts/start-certbot.sh"]
