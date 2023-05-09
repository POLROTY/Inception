# Use the Debian Buster base image for this container
FROM debian:buster


# ugrade and update apt
RUN apt update -y
RUN apt upgrade -y


# install wget to download wordpress
RUN apt-get -y install wget

# install php with the dependencies
RUN apt-get install -y php7.3\
	php-fpm\
	php-mysql\
	mariadb-client

# install php with the dependencies
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www


# unzip the tar and remove the zipped folder
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

# give root the rights to write in the folder
RUN		chown -R root:root /var/www/wordpress

# install CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#give the rights to move
RUN chmod +x wp-cli.phar
# move the file to the right folder
RUN mv wp-cli.phar /usr/local/bin/wp