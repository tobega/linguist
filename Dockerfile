FROM ruby:2-alpine3.13

ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

RUN apk --update add --virtual build_deps \
    build-base \
    libc-dev \
    cmake \
    git \
    && apk add icu-dev openssl-dev
RUN gem install bundler
RUN git clone https://github.com/tobega/linguist.git
WORKDIR linguist
RUN script/bootstrap
RUN bundle exec rake build_gem
RUN gem install github-linguist

CMD ["github-linguist"]
