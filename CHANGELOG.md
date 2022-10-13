## Changelog

## 3063.v26e24490f041-2-36
* Upstream version [docker-inbound-agent 3063.v26e24490f041-2](https://github.com/jenkinsci/docker-inbound-agent/releases/tag/3063.v26e24490f041-2)
* Increased docker version to 20.10.10 - [#27](https://github.com/odavid/jenkins-jnlp-slave/pull/27)

## 4.13.2-1-36
* Upstream version [docker-inbound-agent 4.13.2-1](https://github.com/jenkinsci/docker-inbound-agent/releases/tag/4.13.2-1)

### 4.13-2-35
* Upstream version [docker-inbound-agent 4.13-2](https://github.com/jenkinsci/docker-inbound-agent/releases/tag/4.13-2)

### 4.13-1-34
* Upstream version [docker-inbound-agent 4.13-1](https://github.com/jenkinsci/docker-inbound-agent/releases/tag/4.13-1)

### 4.11.2-4-33
* Fixed wrong tiny download url - [#21](https://github.com/odavid/jenkins-jnlp-slave/pull/21)

### 4.11.2-4-32
* Upstream version [docker-inbound-agent 4.11.2-4](https://github.com/jenkinsci/docker-inbound-agent/releases/tag/4.11.2-4)

### 4.10-2-31
* Upstream version [docker-inbound-agent 4.10-2](https://github.com/jenkinsci/docker-inbound-agent/releases/tag/4.10-2)
* Docker version

### v4.6-1-30
* Upstream version [docker-inbound-agent 4.6-1](https://github.com/jenkinsci/docker-inbound-agent/releases/tag/4.6-1)
* Docker version

### v4.3-9-29
* Upstream version [docker-jnlp-slave 4.3-9](https://github.com/jenkinsci/docker-jnlp-slave/releases/tag/4.3-9)
  * Upgrade upstream to 4.3-9. Removed all glibc installation - being taken care of in upstream image [#15](https://github.com/odavid/jenkins-jnlp-slave/pull/15)

### v4.3-8-28
* Upstream version [docker-jnlp-slave 4.3-8](https://github.com/jenkinsci/docker-jnlp-slave/releases/tag/4.3-8)

### v4.3-7-27
* Upstream version [docker-jnlp-slave 4.3-7](https://github.com/jenkinsci/docker-jnlp-slave/releases/tag/4.3-7)

### v4.3-6-26
* Upstream version [docker-jnlp-slave 4.3-6](https://github.com/jenkinsci/docker-jnlp-slave/releases/tag/4.3-6)

### v4.3-5-25
* Upstream version [docker-jnlp-slave 4.3-5](https://github.com/jenkinsci/docker-jnlp-slave/releases/tag/4.3-5)

### v4.3-4-24
* Upstream version [docker-jnlp-slave 4.3-4](https://github.com/jenkinsci/docker-jnlp-slave/releases/tag/4.3-4)
* Upstream image name changed to [jenkins/inbound-agent](https://hub.docker.com/r/jenkins/inbound-agent)

### v4.3-1-23
* Upstream version [docker-jnlp-slave 4.3-1](https://github.com/jenkinsci/docker-jnlp-slave/releases/tag/4.3-1)

### v4.0.1-1-22
* Upstream version [docker-jnlp-slave 4.0.1-1](https://github.com/jenkinsci/docker-jnlp-slave/releases/tag/4.0.1-1)

### v3.40-1-21
* Upstream version [docker-jnlp-slave 3.40-1](https://github.com/jenkinsci/docker-jnlp-slave/releases/tag/3.40-1)

### v3.36-1-20
* Upstream version [docker-jnlp-slave 3.36-1](https://github.com/jenkinsci/docker-jnlp-slave/releases/tag/3.36-1)
* Docker version

### v3.35-5-19
* [alpine-pkg-glibc 2.30-r0](https://github.com/sgerrand/alpine-pkg-glibc/releases/tag/2.30-r0)
* Upstream version [docker-jnlp-slave 3.35-5](https://github.com/jenkinsci/docker-jnlp-slave/releases/tag/3.35-5)

### v3.35-4-18
* Upstream version and added jdk11 distribution [#11](https://github.com/odavid/jenkins-jnlp-slave/pull/11)
  * In *v3.35-4-17*, jdk11 was actually equal to the jdk8 debian distribution

### v3.35-4-17
* Upstream version and added jdk11 distribution [#11](https://github.com/odavid/jenkins-jnlp-slave/pull/11)

### v3.29-1-16
* Use Docker 19.03 to access GPUs [#9](https://github.com/odavid/jenkins-jnlp-slave/issues/9)

### v3.29-1-15
* Upgrade tini, gosu and docker versions

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