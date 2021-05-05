FROM node:12.16 AS node

FROM ruby:2.4.10

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /opt/yarn-* /opt/yarn
RUN ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn

# Enable jemalloc
RUN apt-get update \
  && apt-get install -y \
    libjemalloc-dev \
    libjemalloc2 \
  && rm -rf /var/lib/apt/lists/*
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2

ENV BUNDLER_VERSION=2.1.4
RUN gem install bundler -v $BUNDLER_VERSION
