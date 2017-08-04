FROM ubuntu:16.04
#MAINTAINER Will Payne <will@paynelabs.io>
ENV WORKDIR=/usr
RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y wget git curl
WORKDIR /tmp

RUN wget https://github.com/prashants/webzash/releases/download/v2.7/webzash-v2.7.tar.gz
RUN tar xvfz webzash-v2.7.tar.gz
RUN ls
