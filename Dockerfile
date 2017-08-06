FROM php:5.6-apache
MAINTAINER Will Payne <will@paynelabs.io>
ENV DEBIAN_FRONTEND noninteractive
ENV CAKEPHP_WEBROOT /var/www/webzash/app/webroot
RUN apt-get update && apt-get -y upgrade \
    && apt-get -y install wget unzip git php5-mysql php5-mcrypt curl \
    && php5enmod mcrypt \
    && curl -sSL https://getcomposer.org/installer | php && mv composer.phar /usr/bin/composer && chmod +x /usr/bin/composer \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* 
RUN docker-php-ext-install mysql mysqli pdo pdo_mysql
WORKDIR /tmp
ADD ./bootstrap.sh /cakephp-bootstrap.sh
RUN wget -O cakephp.zip https://github.com/cakephp/cakephp/zipball/2.10.0 \
  && unzip cakephp.zip \
  && mv cakephp-cakephp-d15d3d9 /var/www/webzash \
  && mv /var/www/webzash/app/Config/database.php.default /var/www/webzash/app/Config/database.php
RUN chmod +x /cakephp-bootstrap.sh

ADD core.php /var/www/webzash/app/Config/
ADD bootstrap.php /var/www/webzash/app/Config/
ADD routes.php /var/www/webzash/app/Config/

RUN git clone https://github.com/slywalker/cakephp-plugin-boost_cake.git /var/www/webzash/app/Plugin/BoostCake
RUN git clone https://github.com/prashants/webzash.git /var/www/webzash/app/Plugin/Webzash
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN chown -R www-data:www-data /var/www && chmod u=rwX,g=srX,o=rX -R /var/www
EXPOSE 80
ENTRYPOINT ["/cakephp-bootstrap.sh"]
RUN a2enmod rewrite

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]