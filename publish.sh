#!/bin/bash
set -e -o pipefail

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

if [[ -n $GIT_TAG ]]; then
    TAG=${GIT_TAG/v/}
    echo "publish $TAG"
	docker tag odavid/jenkins-jnlp-slave odavid/jenkins-jnlp-slave:${TAG}
	docker tag odavid/jenkins-jnlp-slave:alpine odavid/jenkins-jnlp-slave:${TAG}-alpine
	docker tag odavid/jenkins-jnlp-slave:debian odavid/jenkins-jnlp-slave:${TAG}-debian
	docker tag odavid/jenkins-jnlp-slave:jdk11 odavid/jenkins-jnlp-slave:${TAG}-jdk11
    docker tag odavid/jenkins-jnlp-slave:jdk17 odavid/jenkins-jnlp-slave:${TAG}-jdk17
	docker push odavid/jenkins-jnlp-slave:${TAG}
	docker push odavid/jenkins-jnlp-slave:${TAG}-alpine
	docker push odavid/jenkins-jnlp-slave:${TAG}-debian
	docker push odavid/jenkins-jnlp-slave:${TAG}-jdk11
	docker push odavid/jenkins-jnlp-slave:${TAG}-jdk17


else
    echo "publish latest"
	docker push odavid/jenkins-jnlp-slave
	docker push odavid/jenkins-jnlp-slave:alpine
	docker push odavid/jenkins-jnlp-slave:debian
	docker push odavid/jenkins-jnlp-slave:jdk11
	docker push odavid/jenkins-jnlp-slave:jdk17
fi