#!/bin/bash

# Delay execution of the script for 10 seconds. To wait for other services to be ready.
sleep 10

# Check if the WordPress configuration file does not exist
if [ ! -e /var/www/wordpress/wp-config.php ]; then

    # Create a new wp-config.php file with database connection details
    wp config create --allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD \
                     --dbhost=mariadb:3306 --path='/var/www/wordpress'

    # Delay execution of the script for 2 seconds. To wait for the wp-config.php file to be properly created.
    sleep 2

    # Install WordPress with the given parameters
    wp core install --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'
    
    # Create a new WordPress user with the role of 'author'
    wp user create --allow-root --role=author $USER1_LOGIN $USER1_MAIL --user_pass=$USER1_PASS --path='/var/www/wordpress' >> /log.txt
fi

# Check if the /run/php directory does not exist
if [ ! -d /run/php ]; then

    # Create the /run/php directory. This directory is needed for PHP-FPM.
    mkdir ./run/php
fi

# Start the PHP-FPM service. The '-F' option runs PHP-FPM in the foreground, which is often used when running PHP-FPM in Docker.
/usr/sbin/php-fpm7.3 -F
