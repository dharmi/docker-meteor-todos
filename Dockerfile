FROM google/debian:wheezy

MAINTAINER dharmi <dharmi@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        procps \
        && rm -rf /var/lib/apt/lists/*

EXPOSE 8000

RUN curl  https://install.meteor.com/ | sh
RUN meteor create --example todos
WORKDIR /todos
CMD ["meteor", "--port=8000"]