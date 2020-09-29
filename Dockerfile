FROM ubuntu:16.04


ENV TZ=Europe/Moscow

RUN groupadd -g 1005 default && useradd -s /bin/sh -d /home/default -r -u 1005 -g default default
RUN mkdir -p /home/default
RUN chown default:default -R /home/default

RUN apt-get update -qq && \
    apt-get install -qq -y \
            build-essential \
            ca-certificates \
            libssl-dev \
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

USER default

ENV LANG C.UTF-8

ENV PATH /home/default/.asdf/bin:/home/default/.asdf/shims:$PATH

RUN /bin/bash -c "git clone https://github.com/asdf-vm/asdf.git home/default/.asdf && \
                  asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git && \
                  asdf install ruby 2.2.10 && \
                  asdf global ruby 2.2.10 && \
                  rm -rf  /tmp/*"

RUN gem install bundler --no-rdoc --no-ri -v 1.17.3
