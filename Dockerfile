# This dockerfile uses the ubuntu image
# VERSION 2 - EDITION 1
# Author: Jeffer Lau
# Original Author: yidong <yidong@cnezsoft.com>
# Copy from: http://dl.cnezsoft.com/zentao/docker/docker_zentao.zip
# Doc: https://www.zentao.net/download/80098.html
# Command format: Instruction [arguments / command] ..

FROM ubuntu:18.04
MAINTAINER Jeffer Lau <jefferlzu@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN apt-get install -y apache2 mariadb-server php php-curl php-gd php-ldap php-mbstring php-mysql php-xml php-zip php-cli php-json curl unzip libapache2-mod-php tzdata locales

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV LANG="en_US.UTF8"
ENV MYSQL_ROOT_PASSWORD="123456"
RUN echo -e "LANG=\"en_US.UTF-8\"\nLANGUAGE=\"en_US:en\"" > /etc/default/locale && locale-gen en_US.UTF-8

RUN mkdir -p /app/zentaopms
COPY docker-entrypoint.sh /app
RUN random=`date +%s`; curl http://cdn.zentaopm.com/latest/zentao.zip?rand=$random -o /var/www/zentao.zip
RUN cd /var/www/ && unzip -q zentao.zip && rm zentao.zip
RUN a2enmod rewrite

RUN rm -rf /etc/apache2/sites-enabled/000-default.conf /var/lib/mysql/*
RUN sed -i '1i ServerName 127.0.0.1' /etc/apache2/apache2.conf
COPY config/apache.conf /etc/apache2/sites-enabled/000-default.conf
COPY config/ioncube_loader_lin_7.0.so /usr/lib/php/20151012/ioncube_loader_lin_7.0.so
COPY config/00-ioncube.ini /etc/php/7.0/apache2/conf.d/
COPY config/00-ioncube.ini /etc/php/7.0/cli/conf.d/

VOLUME /app/zentaopms /var/lib/mysql
ENTRYPOINT ["/app/docker-entrypoint.sh"]
