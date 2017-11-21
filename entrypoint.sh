#!/bin/bash

if [ "$(id -u)" == "0" ]; then
    chown -R jenkins /home/jenkins
    # To enable docker cloud based on docker socket,
    # we need to add jenkins user to the docker group
    if [ -S /var/run/docker.sock ]; then
        DOCKER_SOCKET_OWNER_GROUP_ID=$(stat -c %g /var/run/docker.sock)
        groups jenkins | grep docker || groupadd -g $DOCKER_SOCKET_OWNER_GROUP_ID docker
        id jenkins -G | grep $DOCKER_SOCKET_OWNER_GROUP_ID || usermod -G docker jenkins
    fi
fi

exec gosu jenkins "jenkins-slave" "$@"