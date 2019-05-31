.PHONY: default
UPSTREAM_VERSION_FILE = UPSTREAM_VERSION.txt
UPSTREAM_VERSION = `cat $(UPSTREAM_VERSION_FILE)`
DEFAULT_BUILD_ARGS = --build-arg http_proxy=$(http_proxy) --build-arg https_proxy=$(https_proxy) --build-arg no_proxy=$(no_proxy)

default: build-alpine

build-all: build-alpine build-debian

build-alpine:
	docker build --rm --force-rm -t odavid/jenkins-jnlp-slave:alpine $(DEFAULT_BUILD_ARGS) --build-arg=FROM_TAG=$(UPSTREAM_VERSION)-alpine .
	docker tag odavid/jenkins-jnlp-slave:alpine odavid/jenkins-jnlp-slave:latest

build-debian:
	docker build --rm --force-rm -t odavid/jenkins-jnlp-slave:debian $(DEFAULT_BUILD_ARGS) --build-arg=FROM_TAG=$(UPSTREAM_VERSION) .

publish-latest: build-all
	docker push odavid/jenkins-jnlp-slave
	docker push odavid/jenkins-jnlp-slave:alpine
	docker push odavid/jenkins-jnlp-slave:debian

publish-tag: build-all
	docker tag odavid/jenkins-jnlp-slave odavid/jenkins-jnlp-slave:$(TAG)
	docker tag odavid/jenkins-jnlp-slave:alpine odavid/jenkins-jnlp-slave:$(TAG)-alpine
	docker tag odavid/jenkins-jnlp-slave:debian odavid/jenkins-jnlp-slave:$(TAG)-debian
	docker push odavid/jenkins-jnlp-slave:$(TAG)
	docker push odavid/jenkins-jnlp-slave:$(TAG)-alpine
	docker push odavid/jenkins-jnlp-slave:$(TAG)-debian

release:
	$(eval NEW_INCREMENT := $(shell expr `git describe --tags --abbrev=0 | cut -d'-' -f3` + 1))
	git tag v$(UPSTREAM_VERSION)-$(NEW_INCREMENT)
	git push origin v$(UPSTREAM_VERSION)-$(NEW_INCREMENT)
