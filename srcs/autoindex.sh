# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    autoindex.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: olydden <olydden@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/16 18:19:59 by olydden           #+#    #+#              #
#    Updated: 2020/10/16 23:14:12 by olydden          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh
if (cat /etc/nginx/sites-available/olydden_site | grep -q "autoindex on"); then
sed -i "s/autoindex on/autoindex off/" /etc/nginx/sites-available/olydden_site
sed -i "s/index_unexist.php/index.php/" /etc/nginx/sites-available/olydden_site
else
sed -i "s/autoindex off/autoindex on/" /etc/nginx/sites-available/olydden_site
sed -i "s/index.php/index_unexist.php/" /etc/nginx/sites-available/olydden_site
fi

nginx -s reload
