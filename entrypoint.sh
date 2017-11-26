#!/bin/bash

if [ "$(id -u)" == "0" ]; then
    if [ "$(stat -c %u /home/jenkins)" != "$(id -u jenkins)" ]; then
        chown -R jenkins /home/jenkins
    fi
    ## If we want to share tools between slaves
    if [[ -d /home/jenkins/tools ]] && [[ "$(stat -c %u /home/jenkins/tools)" != "$(id -u jenkins)" ]]; then
        chown -R jenkins /home/jenkins/tools
    fi
    ## If we want to share maven cache between slaves
    if [[ -d /home/jenkins/.m2 ]] && [[ "$(stat -c %u /home/jenkins/.m2)" != "$(id -u jenkins)" ]]; then
        chown -R jenkins /home/jenkins/.m2
    fi
    ## If we want to share gradle cache between slaves
    if [[ -d /home/jenkins/.gradle ]] && [[ "$(stat -c %u /home/jenkins/.gradle)" != "$(id -u jenkins)" ]]; then
        chown -R jenkins /home/jenkins/.gradle
    fi
    
    # To enable docker cloud based on docker socket,
    # we need to add jenkins user to the docker group
    if [ -S /var/run/docker.sock ]; then
        DOCKER_SOCKET_OWNER_GROUP_ID=$(stat -c %g /var/run/docker.sock)
        echo "jenkins groups: $(id jenkins -G)"
        getent group $DOCKER_SOCKET_OWNER_GROUP_ID || groupadd -g $DOCKER_SOCKET_OWNER_GROUP_ID docker 
        id jenkins -G | grep $DOCKER_SOCKET_OWNER_GROUP_ID || usermod -G "$(id -G jenkins | tr ' ' ','),$DOCKER_SOCKET_OWNER_GROUP_ID" jenkins
        echo "jenkins new groups: $(id jenkins -G)"
    fi
fi

exec gosu jenkins "jenkins-slave" "$@"