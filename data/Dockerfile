FROM ubuntu:16.04
#MAINTAINER Will Payne <will@paynelabs.io>
ENV WORKDIR=/usr
RUN apt-get update && apt-get -y upgrade

RUN apt-get -y install nginx php7.0 php7.0-fpm php7.0-mysql pwgen python-setuptools curl git ssmtp wget
WORKDIR /tmp

COPY webzash.conf /etc/nginx/sites-available/webzash.conf
RUN wget https://github.com/prashants/webzash/releases/download/v2.7/webzash-v2.7.tar.gz
RUN tar xvfz webzash-v2.7.tar.gz
RUN ls
