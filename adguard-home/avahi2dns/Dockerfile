FROM alpine:3.16

ARG A2DV=0.0.2
ARG PUID=${PUID}
ARG PGID=${PGID}

# RUN apk add --no-cache dbus \
#     && rm -rf /tmp/* /var/cache/apk/*

ADD https://github.com/LouisBrunner/avahi2dns/releases/download/0.0.2/avahi2dns-linux-arm64 /usr/bin/avahi2dns

RUN chmod +x /usr/bin/avahi2dns
COPY startup.sh ./startup.sh

EXPOSE 5454/udp 5353/udp
ENTRYPOINT ["./startup.sh"]
VOLUME ["/run/dbus/system_bus_socket"]
