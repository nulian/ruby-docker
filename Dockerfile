FROM ubuntu:16.04

#ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#
#RUN apt-get update && apt-get install -y  --no-install-recommends curl ca-certificates gnupg2 build-essential git
#
#RUN gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
#
#RUN curl -sSL https://get.rvm.io | bash -s stable
#
#RUN /bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.2.10"
#
#RUN /bin/bash -l -c "gem install bundler --no-rdoc --no-ri -v 1.17.3"
#
#ENTRYPOINT ["/bin/bash", "-l", "-c"]

RUN apt-get update -qq && \
    apt-get upgrade -qq -y && \
    apt-get install -qq -y \
            build-essential \
            ca-certificates \
            libssl-dev \
            libreadline-dev \
            zlib1g-dev \
            curl \
            git && \
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
                  asdf install ruby 2.2.10 && \
                  asdf global ruby 2.2.10 && \
                  rm -rf  /tmp/*"

RUN gem install bundler --no-rdoc --no-ri -v 1.17.3
