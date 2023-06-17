# Use the Debian Buster base image for this container
FROM debian:buster

# Update the package lists for upgrades for packages that need upgrading, as well as new packages that have just come into the repositories.
RUN apt update -y

# Upgrade all the installed packages to their latest versions
RUN apt upgrade -y

# Install the MariaDB server. This provides the MySQL database server (metapackage depending on the latest version)
RUN apt-get install mariadb-server -y

# Install the MariaDB client. This provides the MariaDB client binary and related tools
RUN apt-get install mariadb-client -y

# Copy the MariaDB configuration file from your host to the appropriate path within your container. This configuration file is used to customize the behavior of the MariaDB server.
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy the MariaDB launch script from your host to your container. This script starts the MariaDB server, creates a database and user, alters user privileges, etc.
COPY ./tools/mariadb_script.sh /mariadb_script.sh

# Set the command that will be executed when the container starts. In this case, it will execute your MariaDB launch script.
CMD ["bash", "/mariadb_script.sh"]
