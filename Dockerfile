FROM jenkinsci/jnlp-slave:3.14-1-alpine
ARG GOSU_VERSION=1.10
ARG DOCKER_VERSION=17.09.0-ce

USER root

RUN apk add --no-cache curl shadow && \
    curl -SsLo /usr/bin/gosu https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 && \
    chmod +x /usr/bin/gosu

RUN curl -SsLo /tmp/docker.tar.gz https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz && \
    tar -xzf /tmp/docker.tar.gz -C /tmp && \ 
    mv /tmp/docker/docker /usr/bin/docker && \
    rm -rf /tmp/docker /tmp/docker.tar.gz
    
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
