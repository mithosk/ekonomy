FROM ruby:3.4.7-slim

WORKDIR /rails
COPY . .

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
        build-essential \
        curl \
        git \
        libjemalloc2 \
        libyaml-dev \
        pkg-config && \
    ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

RUN bundle install --quiet

RUN bundle exec bootsnap precompile -j 1 app/ lib/
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

ENV RAILS_ENV="production"
ENV ELD_PRELOAD="/usr/local/lib/libjemalloc.so"

CMD ["rails", "server", "-b", "0.0.0.0"]