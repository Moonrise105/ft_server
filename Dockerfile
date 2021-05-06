# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: moonrise <moonrise@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/28 13:24:47 by olydden           #+#    #+#              #
#    Updated: 2021/03/17 22:28:46 by moonrise         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update && apt-get upgrade
RUN apt-get install -y procps && apt-get install -y wget
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server

COPY ./srcs/init.sh ./
COPY ./srcs/nginx.conf ./tmp/nginx.conf
COPY ./srcs/autoindex.sh ./tmp/autoindex.sh
COPY ./srcs/phpmyadmin.inc.php ./tmp/phpmyadmin.inc.php
COPY ./srcs/wp-config.php ./tmp/wp-config.php

CMD bash init.sh
