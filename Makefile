
all:
	@echo All

build:
	docker build . --squash -t blog

run:
	docker run -it -p 4000:4000 -v `pwd`:/app blog bash -c "bundle exec jekyll serve --host 0.0.0.0 --port 4000"

site:
	docker run -it -p 4000:4000 -v `pwd`:/app blog bash -c "bundle exec jekyll build"
