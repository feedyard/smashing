FROM alpine:3.7

LABEL smashing.version="1.1.0" \
      description="Smashing Dashboard gem image based on Alpine" \
      maintainer="nic.cheneweth@thoughtworks.com"

# default smashing port
EXPOSE 3030

# force encoding
ENV LANG=en_US.utf8

# add runtime user and group
ARG UID=1000
ARG GID=1000

RUN \
    # add smashing user and group first to make sure IDs get assigned consistently,
    # regardless of other dependencies
    addgroup -g ${GID} smashing && \
    adduser -D -u ${UID} -s /bin/bash -G smashing smashing && \
    apk update && apk --no-cache upgrade && \
    apk --no-cache add tzdata curl wget bash ruby ruby-bundler nodejs ruby-dev g++ musl-dev make

RUN echo "gem: --no-document" > /etc/gemrc
RUN gem install bundler
RUN gem install json
RUN gem install smashing -v 1.1.0

# The default directory for the feedyard radiator
RUN smashing new dashboard && chown -R smashing:smashing dashboard/
RUN rm dashboard/jobs

# no entrypoint defined as the image is pulled as part of building the actual dashboard container
