#!make
ENV_FILE_EXISTS=$(shell [ -f .env ] && echo 1 || echo 0)
ifeq ($(ENV_FILE_EXISTS), 0)
    $(info Creating default .env file from .env.dist)
    $(shell cp .env.dist .env)
endif

include .env
.PHONY: helps

.DEFAULT_GOAL := helps

RUN_IN_CONTAINER := docker exec -it --env APP_ENV=${APP_ENV} ${PROJECT_NAME}
SUBCOMMAND = $(subst £,=, $(subst +,-, $(filter-out $@,$(MAKECMDGOALS))))

helps:
	@clear
	@printf "\033[36m%-30s\033[0m %s\n" help Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | cut -d: -f2- | sort -t: -k 2,2 | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

include ./makefiles/*.mk

%:
	@echo "END"
