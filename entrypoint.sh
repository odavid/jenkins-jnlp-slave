#!/bin/bash
set -e -o pipefail
if [ "$(id -u)" == "0" ]; then
    # To enable docker cloud based on docker socket,
    # we need to add jenkins user to the docker group
    if [ -S /var/run/docker.sock ]; then
        DOCKER_SOCKET_OWNER_GROUP_ID=$(stat -c %g /var/run/docker.sock)
        groupadd -for -g ${DOCKER_SOCKET_OWNER_GROUP_ID} docker
        id jenkins -G -n | grep docker || usermod -aG docker jenkins
    fi

    # dirs=(
    #     '/home/jenkins/tools'
    #     '/home/jenkins/.m2'
    #     '/home/jenkins/.gradle'
    #     '/home/jenkins/.coursier'
    #     '/home/jenkins/.ivy'
    #     '/home/jenkins/.sbt'
    #     '/home/jenkins'
    # )
    # for d in ${dirs[@]}; do
    #     if [[ -d $d ]] && [[ "$(stat -c %u $d)" != "$(id -u jenkins)" ]]; then
    #         echo "chown -R jenkins $d"
    #         chown -R jenkins $d
    #         echo "chown -R jenkins $d... Done"
    #     fi
    # done
fi

exec gosu jenkins "jenkins-slave" "$@"