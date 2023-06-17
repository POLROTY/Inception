#!/bin/sh

# Start the MariaDB service
service mysql start;

# Create the database specified in the .env file
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Create the user specified in the .env file, on the 'localhost'
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# Grant all privileges to the newly created user on the specified database
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Change the password for the 'root' user using the password specified in the .env file
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Refresh all privileges to ensure they are correctly set and all changes have taken effect
mysql -e "FLUSH PRIVILEGES;"

# Shut down the MariaDB service safely, for the changes to take effect on the next start
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
