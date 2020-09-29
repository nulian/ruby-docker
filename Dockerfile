FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && \
    apt-get install -qq -y \
            build-essential \
            ca-certificates \
            libssl1.0-dev \
            libreadline-dev \
            zlib1g-dev \
            curl \
            git \
            tzdata && \
    apt-get clean -qq -y && \
    apt-get autoclean -qq -y && \
    apt-get autoremove -qq -y && \
    rm -rf /var/cache/debconf/*-old && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc/*

ENV LANG C.UTF-8

ENV PATH /root/.asdf/bin:/root/.asdf/shims:$PATH

RUN /bin/bash -c "git clone https://github.com/asdf-vm/asdf.git ~/.asdf && \
                  asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git && \
                  asdf install ruby 2.3.7 && \
                  asdf global ruby 2.3.7 && \
                  rm -rf  /tmp/*"

RUN gem install bundler --no-rdoc --no-ri -v 1.17.3
