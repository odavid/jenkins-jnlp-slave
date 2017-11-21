# Jenkins JNLP Agent Docker image

This image is based on https://github.com/jenkinsci/docker-jnlp-slave image and fixes permissions issues with volumes created by docker.
The image also contains docker binary and able to mount /var/run/docker.sock to enable the slave to run docker commands on the slave.