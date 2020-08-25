FROM alpine:latest


# Set to actual USR_ID and GRP_ID of the user this should run under
# Uses root by default, unless changed
ENV USR_ID=0 \
    GRP_ID=0 

ENV TZ="America/Los_Angeles"

ARG TARGETARCH
ARG DUPLICACY_WEB_VERSION

# Installing software
RUN apk --update add --no-cache bash ca-certificates dbus  su-exec tzdata                                       &&  \
    export DUPLICACY_ARCH=$([ $TARGETARCH = "amd64" ] && echo "x64" || echo $TARGETARCH)                        &&  \
    export DUPLICACY_URL=https://acrosync.com/duplicacy-web/duplicacy_web_linux_${DUPLICACY_ARCH}_${DUPLICACY_WEB_VERSION} && \
    echo "Fetching duplicacy binary from ${DUPLICACY_URL}"                                                      && \
    wget -nv -O /usr/local/bin/duplicacy_web  ${DUPLICACY_URL} 2>&1                                             && \
    chmod +x /usr/local/bin/duplicacy_web                                                                       && \
    rm -f /var/lib/dbus/machine-id && ln -s /config/machine-id /var/lib/dbus/machine-id

EXPOSE 3875/tcp
VOLUME /config /logs /cache

COPY ./init.sh ./launch.sh /usr/local/bin/

ENTRYPOINT /usr/local/bin/init.sh
