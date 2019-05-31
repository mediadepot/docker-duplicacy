FROM alpine:latest

# Todo - DETECT THIS
ARG PLATFORM=x64

ENV DUPLICACY_WEB_VERSION=1.0.0
ENV DUPLICACY_CLI_VERSION=2.2.0

ENV DUPLICACY_CLI_FILENAME=duplicacy_linux_${PLATFORM}_${DUPLICACY_CLI_VERSION}

ARG DUPLICACY_WEB_URL=https://acrosync.com/duplicacy-web/duplicacy_web_linux_${PLATFORM}_${DUPLICACY_WEB_VERSION}
ARG DUPLICACY_CLI_URL=https://github.com/gilbertchen/duplicacy/releases/download/v${DUPLICACY_CLI_VERSION}/${DUPLICACY_CLI_FILENAME}

# Set to actual USR_ID and GRP_ID of the user this should run under
# Uses root by default, unless changed

ENV USR_ID=0 \
    GRP_ID=0 

# Installing software
RUN apk --update add --no-cache bash ca-certificates dbus jq su-exec                && \
    wget -nv -O /usr/local/bin/duplicacy_web ${DUPLICACY_WEB_URL} 2>&1 				&& \
    wget -nv -O /usr/local/bin/${DUPLICACY_CLI_FILENAME} ${DUPLICACY_CLI_URL} 2>&1	&& \
    chmod +x /usr/local/bin/duplicacy_web                                           && \
    chmod +x /usr/local/bin/${DUPLICACY_CLI_FILENAME}                               && \
    rm /var/lib/dbus/machine-id && ln -s /config/machine-id /var/lib/dbus/machine-id 

EXPOSE 3875/tcp
VOLUME /config /logs /cache

COPY ./init.sh /usr/local/bin/

CMD /usr/local/bin/init.sh

