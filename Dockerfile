FROM ubuntu:14.04
MAINTAINER meks.bazz@gmail.com

# https://github.com/btobolaski/docker-owncloud

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y supervisor apache2 php5 php5-gd php-xml-parser php5-intl php5-mysqlnd php5-json php5-mcrypt smbclient curl libcurl3 php5-curl bzip2 wget inetutils-ping curl pwgen
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/supervisor
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf && a2enconf fqdn

RUN groupadd -r mysql && useradd -r -g mysql -s /usr/sbin/nologin mysql
RUN apt-get install -y mysql-server

RUN sed -i -e "s/^bind-address\s*=\s*127.0.0.1/# bind-address = 127.0.0.1/" \
    -e "/^# bind-address/a skip-networking" \
    -e "/\[mysqld\]/a local-infile=0" /etc/mysql/my.cnf

RUN usermod -s /usr/sbin/nologin www-data

RUN cd /tmp && curl -k https://download.owncloud.org/community/owncloud-7.0.2.tar.bz2 > /tmp/owncloud-7.0.2.tar.bz2
ADD ./configs/autoconfig.php /tmp/autoconfig.php
ADD ./configs/001-owncloud.conf /etc/apache2/sites-available/

RUN rm -f /etc/apache2/sites-enabled/000*
RUN ln -s /etc/apache2/sites-available/001-owncloud.conf /etc/apache2/sites-enabled/
RUN a2enmod rewrite ssl

RUN mkdir /etc/apache2/ssl
ADD ./ssl/server.crt /etc/apache2/ssl/server.crt
ADD ./ssl/server.key /etc/apache2/ssl/server.key

# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# RUN echo "Listen 443" | tee -a /etc/apache2/ports.conf

ADD ./configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD ./scripts/start-up.sh /start-up.sh

EXPOSE 80 443

ENTRYPOINT ["/bin/bash", "-c", "/start-up.sh"]
