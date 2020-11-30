FROM node:12.16-stretch AS node

FROM ruby:2.4-stretch

# Enable jemalloc
RUN apt-get update && apt-get install -y libjemalloc-dev libjemalloc1 && rm -rf /var/lib/apt/lists/*
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.1

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /opt/yarn-* /opt/yarn
RUN ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn
