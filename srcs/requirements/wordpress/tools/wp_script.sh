#!/bin/bash

# Sleep for 15 seconds to allow other services to initialize
echo "Sleeping for 15 seconds to allow other services to initialize..."
sleep 15

# Check if wp-config.php file does not exist
if [ ! -f /var/www/wordpress/wp-config.php ]; then

	echo "Configuring Wordpress..."

	# Create the Wordpress configuration file
	wp-cli.phar config create --allow-root \
		--dbname=${SQL_DATABASE} \
		--dbuser=${SQL_USER} \
		--dbpass=${SQL_PASSWORD} \
		--dbhost=mariadb \
		--path='/var/www/wordpress'
	
	echo "Sleeping for 4 seconds before installing core..."
	sleep 4

	# Install the Wordpress core
	wp-cli.phar core install --url=$DOMAIN_NAME \
                             --title=$SITE_TITLE \
		                     --admin_user=$WP_ADMIN_USER \
                             --admin_password=$WP_ADMIN_PASWORD \
		                     --admin_email=$WP_ADMIN_EMAIL \
                             --skip-email --allow-root \
		                     --path='/var/www/wordpress'

	# Create a new Wordpress user
	wp-cli.phar user create --allow-root \
                            --role=author $WP_USER1_USER $WP_USER1_EMAIL \
		                    --user_pass=$WP_USER1_PASSWORD \
                            --path='/var/www/wordpress' >> /log.txt

	echo "Wordpress configuration is done!"

fi

# Run PHP-FPM
echo "Starting PHP-FPM..."
/usr/sbin/php-fpm7.3 -F


