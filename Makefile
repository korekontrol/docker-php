PHP_IMAGE   ?= korekontrol/php
PHP_TAG     ?= latest
PHP_VERSION ?= 7.4

build:
	docker build --file php/Dockerfile --tag $(PHP_IMAGE):$(PHP_TAG) --build-arg PHP_VERSION=$(PHP_VERSION) .

.PHONY: shell
shell:
	docker run --rm -i -u root -t $(PHP_IMAGE):$(PHP_TAG) bash

.PHONY: trivy
trivy:
	docker pull aquasec/trivy
	docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(HOME)/.cache/trivy/:/root/.cache/trivy/ aquasec/trivy --exit-code 0 --severity HIGH --no-progress $(PHP_IMAGE):$(PHP_TAG)
