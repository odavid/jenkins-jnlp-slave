FROM jenkinsci/jnlp-slave:3.14-1-alpine
ARG GOSU_VERSION=1.10

USER root

RUN apk add --no-cache curl && \
    curl -SsLo /usr/bin/gosu https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 && \
    chmod +x /usr/bin/gosu
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
