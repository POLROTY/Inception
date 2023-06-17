# Use the Debian Buster base image for this container
FROM debian:buster

# Upgrade and update apt to fetch latest information about packages
RUN apt update -y
RUN apt upgrade -y

# Install wget to download wordpress
RUN apt-get -y install wget

# Install php7.3 and the related dependencies needed to run WordPress
RUN apt-get install -y php7.3\
	php-fpm\
	php-mysql\
	mariadb-client

# Download the latest WordPress version from the official WordPress website
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www

# Uncompress the downloaded WordPress tar file and then remove the tar file to clean up space
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

# Copy the PHP-FPM configuration file to the appropriate directory
COPY ./conf/wp-config.conf /etc/php/7.3/fpm/pool.d/www.conf

# Change ownership of the WordPress directory to root
RUN chown -R root:root /var/www/wordpress

# Download WP-CLI, a command-line interface for WordPress 
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Set execute permissions on the downloaded WP-CLI Phar file
RUN chmod +x wp-cli.phar

# Move the WP-CLI Phar file to the /usr/local/bin directory to make it accessible system-wide
RUN mv wp-cli.phar /usr/local/bin/wp

# Copy the WordPress setup script into the container
COPY ./tools/wp_script.sh wp_script.sh

# Set the entrypoint of the Docker image to the WordPress setup script
ENTRYPOINT ["bash", "wp_script.sh"]
