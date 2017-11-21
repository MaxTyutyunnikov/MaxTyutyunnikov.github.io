FROM mangar/jekyll:1.0

MAINTAINER Marcio Mangar "marcio.mangar@gmail.com"

RUN gem install jekyll -v 3.1.6 && \
    gem install bundler && \
    gem install execjs && \
    gem install therubyracer && \
    gem install github-pages && \
    gem install jekyll-paginate && \
    gem install jekyll-seo-tag && \
    gem install jekyll-gist && \
    gem install json -v 1.8.3 && \
    gem install minitest -v 5.9.0 && \
    gem install colorator -v 0.1 && \
    gem install ffi -v 1.9.10 && \
    gem install kramdown -v 1.10.0 && \
    gem install rouge -v 1.10.1 && \
    gem install pkg-config -v 1.1.7 && \
    gem install terminal-table -v 1.6.0 && \
    gem install ethon -v 0.9.0 && \
    gem install nokogiri -v 1.6.8 && \
    gem install activesupport -v 4.2.6 && \
    gem install html-pipeline -v 2.4.1 && \
    gem install jekyll-watch -v 1.4.0 && \
    gem install github-pages-health-check -v 1.1.0 && \
    gem install jekyll-github-metadata -v 2.0.0 && \
    gem install jekyll-mentions -v 1.1.2 && \
    gem install jekyll-redirect-from -v 0.10.0 && \
    gem install jemoji -v 0.6.2 && \
    gem install github-pages -v 82

# Install program to configure locales
RUN apt-get update && apt-get install -y locales

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

# Install needed default locale for Makefly
RUN echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU.UTF-8

RUN mkdir -p /app
ADD ./ /app

WORKDIR /app

EXPOSE 4000

RUN bundle install

CMD bundle exec jekyll serve
