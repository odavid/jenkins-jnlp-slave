## Changelog

### v3.29-1-14
* Support both debian and alpine [#7](https://github.com/odavid/jenkins-jnlp-slave/pull/7)
  * Changing tag scheme from `v$UPSTREAM_TAG-alpine-$INCREMENT` to `v$UPSTREAM_TAG-$INCREMENT[-$DISTRIBUTION]` (currently alpine and debian)
* Using [3.29-1 jenkins/jnlp-slave](https://hub.docker.com/r/jenkins/jnlp-slave/tags) as base image

### v3.27-1-alpine-13
* Added libstdc++ to fix glibc issues when using nodejs and other libs [#6](https://github.com/odavid/jenkins-jnlp-slave/pull/6)

### v3.27-1-alpine-12
* Declared VOLUME for /var/lib/docker

### v3.27-1-alpine-11
* Support for DIND - [#5](https://github.com/odavid/jenkins-jnlp-slave/pull/5)

### v3.27-1-alpine-10
* Add docker-compose - [#3](https://github.com/odavid/jenkins-jnlp-slave/pull/3)

### v3.27-1-alpine-9
* Updated jenkinsci/jnlp-slave:3.27-1-alpine

### v3.16-1-alpine-8
* Updated jenkinsci/jnlp-slave:3.16-1-alpine

### v3.15-1-alpine-7
* Updated jenkinsci/jnlp-slave:3.15-1-alpine
* Access to docker socket

### v3.14-1-alpine-2
* Fixed a case when /var/run/docker.sock was owned by an existing group

### v3.14-1-alpine-1
* First release based on jenkinsci/jnlp-slave:3.14-1-alpine