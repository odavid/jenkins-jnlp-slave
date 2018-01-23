# Jenkins JNLP Agent Docker image

[![Docker Pulls](https://img.shields.io/docker/pulls/odavid/jenkins-jnlp-slave.svg)](https://hub.docker.com/r/odavid/jenkins-jnlp-slave/)

This image is based on https://github.com/jenkinsci/docker-jnlp-slave image and fixes permissions issues with volumes created by docker.
The image also contains docker binary and able to mount /var/run/docker.sock to enable the slave to run docker commands on the slave.
The image is based on alpine and installs also glibc to enable Oracle JDK installations. (see https://github.com/gliderlabs/docker-alpine/issues/11) 