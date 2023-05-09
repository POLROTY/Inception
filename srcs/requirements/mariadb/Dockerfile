# Use the Debian Buster base image for this container
FROM debian:buster


# ugrade and update apt
RUN apt update -y
RUN apt upgrade -y


# install MariaDB
RUN apt-get install mariadb-server -y


# copy the conf file in our container
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf