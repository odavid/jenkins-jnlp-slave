ARG FROM_TAG=3.27-1-alpine

FROM jenkins/jnlp-slave:${FROM_TAG}

ARG GOSU_VERSION=1.10
ARG DOCKER_CHANNEL=stable
ARG DOCKER_VERSION=18.06.1-ce
ARG TINY_VERSION=0.16.1

USER root

RUN \
    # alpine only glibc
    if [ -f /etc/alpine-release ] ; then \
        ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" && \
        ALPINE_GLIBC_PACKAGE_VERSION="2.29-r0" && \
        ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
        ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
        ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
        apk add --no-cache --virtual=.build-dependencies wget curl ca-certificates binutils && \
        echo \
            "-----BEGIN PUBLIC KEY-----\
            MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApZ2u1KJKUu/fW4A25y9m\
            y70AGEa/J3Wi5ibNVGNn1gT1r0VfgeWd0pUybS4UmcHdiNzxJPgoWQhV2SSW1JYu\
            tOqKZF5QSN6X937PTUpNBjUvLtTQ1ve1fp39uf/lEXPpFpOPL88LKnDBgbh7wkCp\
            m2KzLVGChf83MS0ShL6G9EQIAUxLm99VpgRjwqTQ/KfzGtpke1wqws4au0Ab4qPY\
            KXvMLSPLUp7cfulWvhmZSegr5AdhNw5KNizPqCJT8ZrGvgHypXyiFvvAH5YRtSsc\
            Zvo9GI2e2MaZyo9/lvb+LbLEJZKEQckqRj4P26gmASrZEPStwc+yqy1ShHLA0j6m\
            1QIDAQAB\
            -----END PUBLIC KEY-----" | sed 's/   */\n/g' > "/etc/apk/keys/sgerrand.rsa.pub" && \
        wget -q \
            "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
            "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
            "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
        apk add --no-cache \
            "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
            "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
            "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
        \
        rm "/etc/apk/keys/sgerrand.rsa.pub" && \
        \
        GCC_LIBS_URL="https://archive.archlinux.org/packages/g/gcc-libs/gcc-libs-9.1.0-1-x86_64.pkg.tar.xz" \
        && ZLIB_URL="https://archive.archlinux.org/packages/z/zlib/zlib-1%3A1.2.11-3-x86_64.pkg.tar.xz" \
        && curl -Ls ${GCC_LIBS_URL} -o /tmp/gcc-libs.tar.xz \
        && mkdir /tmp/gcc \
        && tar -xf /tmp/gcc-libs.tar.xz -C /tmp/gcc \
        && mv /tmp/gcc/usr/lib/libgcc* /tmp/gcc/usr/lib/libstdc++* /usr/glibc-compat/lib \
        && strip /usr/glibc-compat/lib/libgcc_s.so.* /usr/glibc-compat/lib/libstdc++.so* \
        && curl -Ls ${ZLIB_URL} -o /tmp/libz.tar.xz \
        && mkdir /tmp/libz \
        && tar -xf /tmp/libz.tar.xz -C /tmp/libz \
        && mv /tmp/libz/usr/lib/libz.so* /usr/glibc-compat/lib \
        && \
        /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 && \
        echo "export LANG=en_US.UTF-8" > /etc/profile.d/locale.sh && \
        \
        apk del glibc-i18n && \
        \
        apk del .build-dependencies && \
        rm \
            "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
            "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
            "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
        \
        && rm -rf /tmp/${GLIBC_VER}.apk /tmp/gcc /tmp/gcc-libs.tar.xz /tmp/libz /tmp/libz.tar.xz /var/cache/apk/* \
        ; \
    elif [ -f /etc/debian_version ] ; then \
        echo "Debian, skipping glib installation" \
        ; \
    fi

ENV LANG=en_US.UTF-8

RUN \
    echo "Installing required packages" \
    ; \
    if [ -f /etc/alpine-release ] ; then \
        apk add --no-cache curl shadow iptables \
        ; \
    elif [ -f /etc/debian_version ] ; then \
        apt-get update \
        && apt-get install -y --no-install-recommends curl iptables \
        && rm -rf /var/lib/apt/lists/* \
        ; \
    fi


RUN \
    echo "Installing tiny and gosu" \
    ; \
    curl -SsLo /usr/bin/gosu https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 \
    && chmod +x /usr/bin/gosu \
    && curl -SsLo /usr/bin/tiny https://github.com/krallin/tini/releases/download/v${TINY_VERSION}/tini-amd64 \
    && chmod +x /usr/bin/tiny


RUN \
    echo "Installing docker" \
    ; \
    curl -Ssl "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" | \
    tar -xz  --strip-components 1 --directory /usr/bin/

RUN \
    echo "Installing docker-compose" \
    ; \
    if [ -f /etc/alpine-release ] ; then \
        apk add --no-cache --virtual .build-deps \
            python-dev libffi-dev openssl-dev gcc libc-dev make  py-pip \
        && pip install --upgrade pip \
        && pip install --upgrade docker-compose \
        && apk del .build-deps \
        ; \
    elif [ -f /etc/debian_version ] ; then \
        apt-get update \
        && apt-get install -y --no-install-recommends curl iptables \
        && rm -rf /var/lib/apt/lists/* \
        ; \
    fi

COPY entrypoint.sh /entrypoint.sh

## https://github.com/docker-library/docker/blob/fe2ca76a21fdc02cbb4974246696ee1b4a7839dd/18.06/modprobe.sh
COPY modprobe.sh /usr/local/bin/modprobe
## https://github.com/jpetazzo/dind/blob/72af271b1af90f6e2a4c299baa53057f76df2fe0/wrapdocker
COPY wrapdocker.sh /usr/local/bin/wrapdocker

VOLUME /var/lib/docker

ENTRYPOINT [ "tiny", "--", "/entrypoint.sh" ]
