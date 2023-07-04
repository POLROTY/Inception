# Use the Debian Buster base image for this container
FROM debian:buster

# ugrade and update apt
RUN apt update -y
RUN apt upgrade -y

# Install wget and php with the dependencies
RUN apt-get install -y wget   \
					   php7.3  \
					   php-fpm  \
					   php-mysql \
					   mariadb-client

# Download WordPress
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www

# Unzip the tar and remove the zipped folder
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

# Copy the configuration file into the correct directory
COPY ./conf/wp-config.conf /etc/php/7.3/fpm/pool.d/www.conf

# Give root user the ownership rights to the /var/www/wordpress directory
RUN chown -R root:root /var/www/wordpress

# Install WP-CLI (WordPress Command Line Interface)
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp-cli.phar

# Copy the shell script file into the Docker container
COPY ./tools/wp_script.sh wp_script.sh

# Set the entry point for the Docker container to the shell script
ENTRYPOINT ["bash", "wp_script.sh"]
