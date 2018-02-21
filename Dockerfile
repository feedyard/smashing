FROM alpine:3.7

LABEL smashing.version="1.1.0" \
      description="Smashing Dashboard gem image based on Alpine" \
      maintainer="nic.cheneweth@thoughtworks.com"

# force encoding
ENV LANG=en_US.utf8

RUN apk update && apk --no-cache upgrade && \
    apk --no-cache add tzdata curl wget bash ruby ruby-bundler nodejs ruby-dev g++ musl-dev make

RUN echo "gem: --no-document" > /etc/gemrc
RUN gem install bundler json
RUN gem install smashing -v 1.1.0

# The default directory for the feedyard radiator
RUN smashing new dashboard

# no entrypoint defined as the image is pulled as part of building the actual dashboard container
