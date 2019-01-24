FROM alpine:latest

ENV VERSION=0.2.10

RUN  apk --update add --no-cache bash ca-certificates && \
    wget -nv -O /usr/local/bin/duplicacy_web                      \
        https://acrosync.com/duplicacy-web/duplicacy_web_linux_x64_${VERSION} && \
    chmod +x /usr/local/bin/duplicacy_web  && \
    rm -rf /tmp/* && rm -rf /var/cache/apk/*                                                             

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh                          
                            
VOLUME /config
VOLUME /logs
VOLUME /cache

EXPOSE 3875/tcp

CMD [ "/usr/local/bin/entrypoint.sh" ]
