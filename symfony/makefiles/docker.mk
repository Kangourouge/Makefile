#!make
.PHONY: start-docker stop-docker ps start stop recreate rebuild logs build

DOCKER_COMPOSE=docker-compose --project-name=${PROJECT_NAME}
APP_IMAGE_NAME?=${PROJECT_NAME}
APP_IMAGE_TAG?=latest
APP_IMAGE_NAMESPACE?=kangourouge
APP_IMAGE=${APP_IMAGE_NAMESPACE}/${APP_IMAGE_NAME}
COMPOSER_AUTH?=$(shell test -f ~/.composer/auth.json && cat ~/.composer/auth.json)
DOCKER_BUILD_DIR?=.

# Project containers
start-docker: ## (Docker) Start containers (for this project only)
	@${DOCKER_COMPOSE} up -d

stop-docker: ## (Docker) Stop containers (for this project only)
	@${DOCKER_COMPOSE} down --remove-orphans

ps: ## (Docker) Show containers (for this project only)
	@echo "\nProject :\n"
	@${DOCKER_COMPOSE} ps

# All
start: start-docker ## (Docker) Start : containers (for this project only)

stop: stop-docker ## (Docker) Stop : containers (for this project only)

restart: stop start ## (Docker) Restart containers (for this project only)

recreate: stop ## (Docker) Restart : containers with re-build app container (for this project only)
	@if [ "$(APP_ENV)" = "dev" ]; then \
		${DOCKER_COMPOSE} up --force-recreate --build -d; \
	else \
		${DOCKER_COMPOSE} up --force-recreate -d; \
	fi

build: build
	${DOCKER_COMPOSE} build -no-cache

logs: logs
	${DOCKER_COMPOSE} logs -f
