PHP_IMAGE   ?= korekontrol/php
PHP_TAG     ?= latest
PHP_VERSION ?= 7.3

build:
	docker build --file php/Dockerfile --tag $(PHP_IMAGE):$(PHP_TAG) --build-arg PHP_VERSION=$(PHP_VERSION) .

.PHONY: php
php:
	docker run --rm -i -t $(PHP_IMAGE):$(PHP_TAG)
	#bash