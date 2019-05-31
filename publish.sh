#!/bin/bash
set -e -o pipefail

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

if [[ -n $TRAVIS_TAG ]]; then
    TAG=${TRAVIS_TAG/v/}
    echo "publish $TAG"
	docker tag odavid/jenkins-jnlp-slave odavid/jenkins-jnlp-slave:$(TAG)
	docker tag odavid/jenkins-jnlp-slave:alpine odavid/jenkins-jnlp-slave:$(TAG)-alpine
	docker tag odavid/jenkins-jnlp-slave:debian odavid/jenkins-jnlp-slave:$(TAG)-debian
	docker push odavid/jenkins-jnlp-slave:$(TAG)
	docker push odavid/jenkins-jnlp-slave:$(TAG)-alpine
	docker push odavid/jenkins-jnlp-slave:$(TAG)-debian
else
    echo "publish latest"
	docker push odavid/jenkins-jnlp-slave
	docker push odavid/jenkins-jnlp-slave:alpine
	docker push odavid/jenkins-jnlp-slave:debian
fi