# Use the Debian Buster base image for this container
FROM debian:buster


# ugrade and update apt
RUN apt update -y
RUN apt upgrade -y


# install MariaDB server
RUN apt-get install mariadb-server -y

# install MariaDB client
RUN apt-get install mariadb-client -y

# copy the conf file in our container
COPY ./conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
# copy the launch scropt in our container
COPY	./tools/mariadb_script.sh /mariadb_script.sh

CMD     ["bash", "/mariadb_script.sh"]