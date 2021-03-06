# based on https://github.com/codeclimate/codeclimate-rubocop/blob/master/Dockerfile

FROM codeclimate/alpine-ruby:b38

MAINTAINER Andy Waite

WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN apk --update add \
    ruby \
    ruby-dev \
    ruby-bundler \
    build-base \
    git && \
    bundle install -j 4 && \
    apk del build-base && \
    rm -fr /usr/share/ri

RUN adduser -u 9000 -D app
USER app

COPY . /usr/src/app

CMD ["/usr/src/app/bin/codeclimate-doby"]
