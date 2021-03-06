.DEFAULT_GOAL := help
BLOG=blog

.PHONY: help

# self-documented makefile
help:
#	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@git pull --all

all: push
	@echo push

build: ## Собрать докер
	@docker build . --squash -t ${BLOG}

run: ## Запустить локальный сайт
	@docker run --rm -p 4000:4000 -v `pwd`:/app --name ${BLOG} ${BLOG} bash -c "bundle exec jekyll serve --host 0.0.0.0 --port 4000"

run_dr: ## Запустить локальный сайт
	@docker run --rm -p 4000:4000 -v `pwd`:/app --name ${BLOG} ${BLOG} bash -c "bundle exec jekyll serve --host 0.0.0.0 --port 4000 --drafts"

site: ## Сайт
	@docker run -it --rm -p 4000:4000 -v `pwd`:/app --name ${BLOG} ${BLOG} bash -c "bundle exec jekyll build"

push: site ## Залить на github
	@git add .
	@git commit -a -m "Update Site"  || true
	@git push --all

clean: ## очистка
	# I always forget the syntax
	@[ "`docker ps -a -q -f status=exited`" != "" ] && docker rm `docker ps -a -q -f status=exited` || exit 0
	@[ "`docker images -a -q -f dangling=true`" != "" ] && docker rmi `docker images -a -q -f dangling=true` || exit 0

