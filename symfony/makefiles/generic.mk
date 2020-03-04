#!make
.PHONY: console composer sh bash behat phpunit phpcs phpcbf shell

# Generic

console: ## (Generic) Symfony console | example : make console cache:clear ++env=prod [++help]
	${RUN_IN_CONTAINER} ./bin/console ${SUBCOMMAND}

composer: ## (Generic) Composer | example : make composer install ++optimize-autoloader [++help]
	${RUN_IN_CONTAINER} composer ${SUBCOMMAND};

sh: ## (Generic) Shell Sh | example : make sh 'ls -lah'
	${RUN_IN_CONTAINER} sh -c "${SUBCOMMAND}"

bash: ## (Generic) Shell Bash | example : make bash 'tail -f ./path/to/a/file'
	${RUN_IN_CONTAINER} bash -c "${SUBCOMMAND}"

# BINs
behat: ## (Generic) Behat | example : make behat [++help]
	docker exec -it --env APP_ENV=test ${PROJECT_NAME} ./vendor/bin/behat ${SUBCOMMAND}

phpunit: ## (Generic) PHP Unit | example : make phpunit [++help]
	@echo ${SUBCOMMAND}
	${RUN_IN_CONTAINER} ./vendor/bin/phpunit --configuration ./phpunit.xml.dist ${SUBCOMMAND}

phpcs: ## (Generic) PHP Code Style | example : make phpcs [++help]
	${RUN_IN_CONTAINER} ./vendor/bin/phpcs ${SUBCOMMAND}

phpcbf: ## (Generic) PHP Code Beautifier and Fixer | example : make phpcbf [++help]
	${RUN_IN_CONTAINER} ./vendor/bin/phpcbf ${SUBCOMMAND}

php: ## (Generic) PHP | example : make php [++help]
	${RUN_IN_CONTAINER} /usr/local/bin/php ${SUBCOMMAND}

shell: ## (Generic) Enter in app container
	$(RUN_IN_CONTAINER) bash
