
all:
	@echo All

build:
	docker build . --squash -t blog

run:
	docker run -it -p 4000:4000 -v `pwd`:/app blog bash -c "bundle exec jekyll serve --host 0.0.0.0 --port 4000"

site:
	docker run -it -p 4000:4000 -v `pwd`:/app blog bash -c "bundle exec jekyll build"

push: site
	git add .
	git commit -a -m "Update Site"  || true
	git push --all

clean:
	# I always forget the syntax
	[ "`docker ps -a -q -f status=exited`" != "" ] && docker rm `docker ps -a -q -f status=exited` || exit 0
	[ "`docker images -a -q -f dangling=true`" != "" ] && docker rmi `docker images -a -q -f dangling=true` || exit 0
