#!/bin/sh

exec mysqld_safe
echo "MySQL server is starting..."

# while mysqladmin ping command does not succeed
while ! mysqladmin ping >/dev/null 2>&1
do
  echo "MariaDB is starting..."
  sleep 1
done
echo "MariaDB is running!"

mysql -u root -p$SQL_ROOT_PASSWORD --execute "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
echo "Database '${SQL_DATABASE}' created or already exists!"

mysql -u root -p$SQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
echo "Root user's password updated!"

mysql -u root -p$SQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
echo "User '${SQL_USER}' created or already exists!"

mysql -u root -p$SQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
echo "All privileges on database '${SQL_DATABASE}' granted to '${SQL_USER}'!"

mysql -u root -p$SQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
echo "User privileges have been updated!"

mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
echo "MariaDB has been shutdown!"

exec mysqld
echo "MariaDB has been started!"


