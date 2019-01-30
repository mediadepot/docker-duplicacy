FROM alpine:latest

ENV DUPLICACY_WEB_VERSION=0.2.10

# Set to actual USR_ID and GRP_ID of the user this should run under
# Uses root by default, unless changed

ENV USR_ID=0 \
    GRP_ID=0 

# Installing software
RUN apk --update add --no-cache bash ca-certificates dbus  su-exec                  && \
    wget -nv -O /usr/local/bin/duplicacy_web                                           \
        https://acrosync.com/duplicacy-web/duplicacy_web_linux_x64_${DUPLICACY_WEB_VERSION} 2>&1 && \
    chmod +x /usr/local/bin/duplicacy_web                                           && \
    rm -rf /tmp/*                                                                   && \
    rm -rf /var/cache/apk/*

EXPOSE 3875/tcp
VOLUME /config /logs /cache

COPY ./init.sh ./launch.sh /usr/local/bin/

ENTRYPOINT /usr/local/bin/init.sh
