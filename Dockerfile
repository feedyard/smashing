FROM alpine:3.5
# ruby 2.3.3p222 (2016-11-21 revision 56859) [x86_64-linux-musl]
# nodejs --version = v6.9.2

MAINTAINER Nic Chenewth <nic.cheneweth@thoughtworks.com>

RUN apk update && apk upgrade
RUN apk add curl wget bash ruby ruby-bundler nodejs ruby-dev g++ musl-dev make

RUN echo "gem: --no-document" > /etc/gemrc
RUN gem install bundler
RUN gem install json
RUN gem install smashing -v 1.0.0

# The default directory for the feedyard radiator
RUN smashing new dashboard

# there is no CMD or other execution instructions since this image is designed to be included in the feedyard/dashboard image