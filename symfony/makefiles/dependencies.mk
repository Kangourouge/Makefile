# rules based on files
EXEC_PHP        = $(DOCKER_COMPOSE) exec -T php /entrypoint
EXEC_JS         = $(DOCKER_COMPOSE) exec -T node /entrypoint

SYMFONY         = $(EXEC_PHP) bin/console
COMPOSER        = $(EXEC_PHP) composer
YARN            = yarn

composer.lock: composer.json
	$(COMPOSER) update --lock --no-scripts --no-interaction

vendor: composer.lock ## (base) vendor ta soeir
	$(COMPOSER) install

node_modules: yarn.lock  ## (base) yarn ta soeir
	$(YARN) install
	@touch -c node_modules

yarn.lock: package.json ## (test) test
	$(YARN) upgrade

.env.local: .env.local.docker ## (dfsdfsdf) sdfsdf
	@if [ -f .env ]; \
	then\
		echo '\033[1;41m/!\ The .env.local.docker file has changed. Please check your .env.local file (this message will not be displayed again).\033[0m';\
		touch .env.local;\
		exit 1;\
	else\
		echo cp .env.local.docker .env.local;\
		cp .env.local.docker .env.local;\
	fi
