#/bin/bash

if [ ! -f /var/lib/mysql/ibdata1 ]; then
    
    mysql_install_db
    
    /usr/bin/mysqld_safe &
    sleep 10s

    # userid: admin - password: generated
    echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY '$(pwgen -1 -s -y)' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql

    # owncloud
    echo "CREATE DATABASE owncloud" | mysql
    dbpass=$(pwgen -1 -s -y)
    #mysqlpass="O/BZZ5P9"
    echo $dbpass > /var/lib/mysql/pass_here
    echo "CREATE USER 'oc-user'@'localhost' IDENTIFIED BY '$dbpass'" | mysql

    echo "GRANT ALL PRIVILEGES ON owncloud.* TO 'oc-user'@'localhost'; FLUSH PRIVILEGES" | mysql 

    sed -i -e "s/PASSWORD_HERE/$dbpass/" /tmp/autoconfig.php
    
    killall mysqld
    sleep 10s
    chown -R mysql.mysql /var/lib/mysql
fi

if [ ! -d /var/owncloud/data -o ! -f /var/www/owncloud/index.php ]; then
    mkdir -p /var/owncloud/data
    chmod 700 /var/owncloud/data
    tar jxvf /tmp/*.tar.bz2 -C /var/www
    
    mv /tmp/autoconfig.php /var/www/owncloud/config
    chown -R www-data:www-data /var/owncloud /var/www
fi
# -n: Run it in the foreground for debugging

supervisord -n
