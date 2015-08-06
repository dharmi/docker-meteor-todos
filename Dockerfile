FROM nginx

MAINTAINER dharmi <dharmi@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        && rm -rf /var/lib/apt/lists/*

ENV METEOR_RELEASE 1.1.0.2

# expose 8080 port
EXPOSE 8080

# install MeteorJS
RUN curl  https://install.meteor.com/ 2>/dev/null | sed 's/^RELEASE/#RELEASE/'| RELEASE=$METEOR_RELEASE sh

# create the todos application
RUN meteor create --example todos
WORKDIR /todos

# run the application with the default MongoDB settings.
CMD ["meteor", "--port=8080"]