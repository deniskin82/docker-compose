ARG MM_VERSION=7.8.1
FROM alpine:3.16

ARG edition=team
ARG PUID=${PUID}
ARG PGID=${PGID}

# Some ENV variables
ENV PATH="/mattermost/bin:${PATH}"
ARG MM_VERSION
ENV MM_VERSION=${MM_VERSION}

# Install some needed packages
RUN apk add --no-cache \
    ca-certificates \
    curl \
    jq \
    libc6-compat \
    libffi-dev \
    libcap \
    linux-headers \
    mailcap \
    netcat-openbsd \
    xmlsec-dev \
    tzdata \
    && rm -rf /tmp/*

RUN mkdir -p /mattermost/data /mattermost/plugins /mattermost/client/plugins

# Get Mattermost
RUN curl https://releases.mattermost.com/${MM_VERSION}/mattermost-${edition}-${MM_VERSION}-linux-arm64.tar.gz?src=docker | tar -xvz \
  && mv /mattermost/config/config.json /config.json.save \
  && addgroup -g ${PGID} mattermost \
  && adduser -D -u ${PUID} -G mattermost -h /mattermost -D mattermost \
  && curl https://raw.githubusercontent.com/mattermost/mattermost-docker-preview/master/config_docker.json -o /mattermost/config/config.json \
  && chown -R mattermost:mattermost /mattermost /config.json.save /mattermost/plugins /mattermost/client/plugins \
  && setcap cap_net_bind_service=+ep /mattermost/bin/mattermost

USER mattermost

#Healthcheck to make sure container is ready
HEALTHCHECK --interval=30s --timeout=10s \
  CMD curl -f http://localhost:8065/api/v4/system/ping || exit 1

WORKDIR /mattermost
CMD ["mattermost"]

# Expose ports of the container
EXPOSE 8065 8067 8074 8075

# Declare volumes for mount point directories
VOLUME ["/mattermost/data", "/mattermost/logs", "/mattermost/config", "/mattermost/plugins", "/mattermost/client/plugins"]
