COMPOSE_PROJECT_NAME ?= hello-world
DOCKER_COMPOSE = docker-compose --project-name $(COMPOSE_PROJECT_NAME) --file docker-compose.yml
DOCKER_BUILDKIT ?= 1
command ?= bash

# If running on linux - build dev container with UID/GID set to the same value, as local user
ifeq ($(UNAME_S),Linux)
	$(BUILD_ARGS) = PHP_UID=$(shell id -u) PHP_GID=$(shell id -g)
endif

# Docker Container quick access custom command, if empty - run interactive shell
docker: start
	$(DOCKER_COMPOSE) exec dev $(command)

# Build docker containers
build:
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=$(DOCKER_BUILDKIT) $(BUILD_ARGS) $(DOCKER_COMPOSE) build

# Start all docker containers, display logs
up:
	$(DOCKER_COMPOSE) up

# Start all docker containers in the background
start:
	$(DOCKER_COMPOSE) up -d

# Stop and remove all containers
down:
	$(DOCKER_COMPOSE) down

# Stop and remove all containers; remove data volumes
clean:
	$(DOCKER_COMPOSE) down -v --remove-orphans
	-rm -rf vendor
