# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: olydden <olydden@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/16 17:22:51 by olydden           #+#    #+#              #
#    Updated: 2020/10/16 23:49:24 by olydden          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

service mysql start

# config access
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# site folder
mkdir /var/www/olydden_site && touch /var/www/olydden_site/index.php
echo "<?php phpinfo(); ?>" >> /var/www/olydden_site/index.php

# ssl certificate
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/olydden_site.pem -keyout /etc/nginx/ssl/olydden_site.key -subj "/C=RU/ST=Moscow/L=Moscow/O=21 School/OU=olydden/CN=olydden_site"

# nginx
mv ./tmp/nginx.conf /etc/nginx/sites-available/olydden_site
ln -s /etc/nginx/sites-available/olydden_site /etc/nginx/sites-enabled/olydden_site
rm -rf /etc/nginx/sites-enabled/default

# mysql
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# phpmyadmin
mkdir /var/www/olydden_site/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/olydden_site/phpmyadmin
mv ./tmp/phpmyadmin.inc.php /var/www/olydden_site/phpmyadmin/config.inc.php

# wordpress
cd /tmp/
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/olydden_site
mv /tmp/wp-config.php /var/www/olydden_site/wordpress

service php7.3-fpm start
service nginx start
bash
