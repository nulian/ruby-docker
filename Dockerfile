FROM ubuntu:16.04

RUN apt-get update && apt-get install -y curl ca-certificates gnupg2 build-essential


RUN gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

RUN curl -sSL https://get.rvm.io | bash -s stable

RUN /bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.2.10"
