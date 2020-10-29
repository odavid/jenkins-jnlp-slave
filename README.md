# Jenkins JNLP Agent Docker image

[![Build Status](https://travis-ci.com/odavid/jenkins-jnlp-slave.svg?branch=master)](https://travis-ci.com/odavid/jenkins-jnlp-slave)
[![Docker Pulls](https://img.shields.io/docker/pulls/odavid/jenkins-jnlp-slave.svg)](https://hub.docker.com/r/odavid/jenkins-jnlp-slave/)
[![Changelog](https://img.shields.io/github/v/tag/odavid/jenkins-jnlp-slave?label=changelog)](https://github.com/odavid/jenkins-jnlp-slave/blob/master/CHANGELOG.md)

This image is based on https://github.com/jenkinsci/docker-inbound-agent image and fixes permissions issues with volumes created by docker.
The image also contains docker binary and able to mount /var/run/docker.sock to enable the slave to run docker commands on the slave.
The default tag of the image is based on alpine and installs also glibc to enable Oracle JDK installations. (see https://github.com/gliderlabs/docker-alpine/issues/11)

The immage support running docker commands in slave in 2 different modes:

* By mounting the host's /var/run/docker.sock inside the slave.
  * docker commands are running on the host's docker daemon.
  * Containers and images built by the slave are not cleaned up.
  * Cannot mount volumes from the slave's workspace - i.e hard to use docker-compose
* By using *Docker Inside Docker* - requires `privileged` container and passing `DIND=true` variable.
  * docker commands are running within the slave's docker daemon.
  * Containers and images built by the slave are cleaned up directly after slave finishes the build.
  * Ability to mount volumes from the slave's workspace - native usage of docker-compose

## Environment Variables

|Name|Description|
-----|------------
`DIND` | If `true`, then the slave will run *docker inside docker* - Requires `privileged` container

For other environment variables, see https://github.com/jenkinsci/docker-inbound-agent

## Releases
Docker Images are pushed to [Docker Hub](https://hub.docker.com/r/odavid/jenkins-jnlp-slave/)

Each release is a git tag v$UPSTREAM_VERSION-$INCREMENT where:

* UPSRTEAM_VERSION is the [docker-inbound-agent](https://github.com/jenkinsci/docker-inbound-agent) version
* INCREMENT is a number representing that representing the release contents (i.e docker version, bugs, etc...)

For each git tag, there following tags will be created:
* $UPSRTEAM_VERSION-$INCREMENT - one to one releationship with git tag
* $UPSRTEAM_VERSION - latest release for that UPSRTEAM_VERSION version

The following distributions are supported:
* alpine (also the default)
* debian
* jdk11