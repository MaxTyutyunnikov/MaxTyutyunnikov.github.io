
build:
	docker build . -t blog

run:
	docker run -p 4000:4000 -v `pwd`:/app blog bash -c "bundle install; bundle exec jekyll serve --host 0.0.0.0 --port 4000" -it
#	docker run -p 4000:4000 -v `pwd`:/app mangar/jekyll:1.1 bash -c "bundle install; bundle exec jekyll serve"
#	docker run -p 4000:4000 -v `pwd`:/src jekyll/jekyll bash -c "bundle install; bundle exec jekyll serve"

site:
	docker run -p 4000:4000 -v `pwd`:/app blog bash -c "bundle install; bundle exec jekyll build"
