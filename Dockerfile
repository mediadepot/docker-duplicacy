FROM alpine:latest

ENV DUPLICACY_WEB_VERSION=0.2.10

# Set to actual USR_ID and GRP_ID of the user this should run under
# Uses root by default, unless changed

ENV USR_ID=0 \
    GRP_ID=0 
    

# Set to true to persist machine-id in the configuration folder. 
# Prevents license invalidation when container is rebuilt.    

ENV PERSISTENT_MACHINE_ID=true


RUN apk --update add --no-cache bash ca-certificates dbus  su-exec                  && \
    wget -nv -O /usr/local/bin/duplicacy_web                                           \
        https://acrosync.com/duplicacy-web/duplicacy_web_linux_x64_${DUPLICACY_WEB_VERSION}  && \
    chmod +x /usr/local/bin/duplicacy_web                                           && \
    rm -rf /tmp/*                                                                   && \
    rm -rf /var/cache/apk/*                                                         && \
    # Nuking extra users and replacing them with minimim required ones
    echo "root:x:0:root" > /etc/group                                               && \
    echo "root:x:0:0:root:/root:/bin/ash" > /etc/passwd                             && \
    # Adding requested user
    if [ $GRP_ID -ne 0 ]; then addgroup -g $GRP_ID -S duplicacy; fi                 && \
    if [ $USR_ID -ne 0 ]; then adduser -u $USR_ID -S duplicacy -G duplicacy; fi     


EXPOSE 3875/tcp
VOLUME /config /logs /cache

COPY ./init.sh     /usr/local/bin/init.sh
COPY ./launch.sh   /usr/local/bin/launch.sh  

ENTRYPOINT /usr/local/bin/init.sh
